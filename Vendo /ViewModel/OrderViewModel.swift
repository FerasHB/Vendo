//
//  OrderManager.swift
//  Vendo
//
//  Created by feras hababa on 22.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class OrderViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var orders: [CartItem] = []
    @Published var errorMessage: String? = nil
    
    private let orderManager = OrderManager.shared
    
    // MARK: - Methods
    
    /// Lädt die Bestellungen für den aktuellen Benutzer.
      func fetchOrders() {
          guard let userId = Auth.auth().currentUser?.uid else {
              errorMessage = "Kein Benutzer angemeldet."
              return
          }
          
          Task {
              do {
                  let fetchedOrders = try await orderManager.fetchOrders(userId: userId)
                    orders = fetchedOrders
                    
              } catch {
                    errorMessage = "Fehler beim Laden der Bestellungen: \(error.localizedDescription)"
                    
              }
          }
      }
      
      /// Fügt ein Produkt zur Bestellhistorie hinzu.
      func addToOrder(cartItem: CartItem) {
          guard let userId = Auth.auth().currentUser?.uid else {
                errorMessage = "Kein Benutzer angemeldet."
              return
          }
          Task {
              do {
                  try await orderManager.addToOrder(userId: userId, cartItem: cartItem)
                  fetchOrders()
              } catch {
                  errorMessage = "Fehler beim Hinzufügen zur Bestellung: \(error.localizedDescription)"
              }
          }
      }
      
      /// Leert die Bestellhistorie des aktuellen Benutzers.
      func clearOrders() {
          guard let userId = Auth.auth().currentUser?.uid else {
              errorMessage = "Kein Benutzer angemeldet."
              return
          }
          
          Task {
              do {
                  try await orderManager.clearOrders(userId: userId)
                  orders.removeAll()
              } catch {
                  errorMessage = "Fehler beim Leeren der Bestellungen: \(error.localizedDescription)"
              }
          }
      }
  }
