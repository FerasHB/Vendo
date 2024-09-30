//
//  CartManger.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class CartViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var items: [CartItem] = []
    @Published var total: Double = 0.0
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
   
    
    // MARK: - Private Properties
    private let cartManager = CartManager.shared
    
   
    // MARK: - Cart Management
    
    /// Lädt den Warenkorb für den aktuellen Benutzer.
       func loadCart() {
           guard let userId = Auth.auth().currentUser?.uid else {
                    errorMessage = "Kein Benutzer angemeldet."
               return
               
           }
           isLoading = true
           Task {
               do {
                   let items = try await cartManager.loadCart(userId: userId)
                       self.items = items
                   calculateTotal()
                   isLoading = false

               } catch {
                   errorMessage = "Fehler beim Laden des Warenkorbs: \(error.localizedDescription)"

               }
               
           }
           
       }
       
       /// Fügt ein Produkt zum Warenkorb hinzu.
       func addToCart(product: Product) {
           guard let userId = Auth.auth().currentUser?.uid else {
               errorMessage = "Kein Benutzer angemeldet."
               return
           }
           
           Task {
               do {
                   try await cartManager.addToCart(userId: userId, product: product)
                   loadCart()
               } catch {
                   errorMessage = "Fehler beim Hinzufügen zum Warenkorb: \(error.localizedDescription)"
               }
           }
       }
       
       /// Entfernt ein Produkt aus dem Warenkorb.
       func removeFromCart(cartItem: CartItem) {
           guard let userId = Auth.auth().currentUser?.uid else {
               errorMessage = "Kein Benutzer angemeldet."
               return
           }
           
           Task {
               do {
                   try await cartManager.removeFromCart(userId: userId, cartItem: cartItem)
                   loadCart()
               } catch {
                   errorMessage = "Fehler beim Entfernen aus dem Warenkorb: \(error.localizedDescription)"
               }
           }
       }
       
       /// Leert den Warenkorb des aktuellen Benutzers nachdem kauf bestätigung
    
       func clearCart() {
           guard let userId = Auth.auth().currentUser?.uid else {
               errorMessage = "Kein Benutzer angemeldet."
               return
           }
           
           Task {
               do {
                   try await cartManager.clearCart(userId: userId)
                   items.removeAll()
                   calculateTotal()
               } catch {
                   errorMessage = "Fehler beim Leeren des Warenkorbs: \(error.localizedDescription)"
               }
           }
       }
       
       /// Berechnet die Gesamtsumme des Warenkorbs
       private func calculateTotal() {
           total = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
       }
   }
