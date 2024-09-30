//
//  CartManager2.swift
//  Vendo
//
//  Created by feras  hababa  on 25.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CartManager {
    
    // Singleton-Instanz, um den Manager überall verwenden zu können
    static let shared = CartManager()
    
    // Firestore-Instanz
    private let store = Firestore.firestore()
    
    // MARK: - Methods
    
    /// Lädt den Warenkorb für einen bestimmten Benutzer aus Firestore.
    /// - Parameter userId: Die Benutzer-ID, für den der Warenkorb geladen wird.
    /// - Returns: Ein Array von CartItems.
    func loadCart(userId: String) async throws -> [CartItem] {
        return try await store
            .collection("users")
            .document(userId)
            .collection("cart")
            .getDocuments()
            .documents
            .map { try $0.data(as: CartItem.self) }
    }
    
    /// Fügt ein Produkt zum Warenkorb hinzu und speichert es in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt hinzugefügt wird.
    ///   - product: Das hinzuzufügende Produkt.
    func addToCart(userId: String, product: Product) async throws {
        let cartItems = try await loadCart(userId: userId)
        
        if let existingItem = cartItems.first(where: { $0.product.id == product.id }) {
            var updatedItem = existingItem
            updatedItem.quantity += 1
            try await saveToFirestore(userId: userId, cartItem: updatedItem)
        } else {
            let newItem = CartItem(product: product, quantity: 1)
            try await saveToFirestore(userId: userId, cartItem: newItem)
        }
    }
    
    /// Entfernt ein Produkt aus dem Warenkorb.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt entfernt wird.
    ///   - cartItem: Das zu entfernende Produkt.
    func removeFromCart(userId: String, cartItem: CartItem) async throws {
        try await deleteCartItemFromFirestore(userId: userId, cartItem: cartItem)
    }
    
    /// Leert den Warenkorb des angegebenen Benutzers und entfernt alle Produkte aus Firestore.
    /// - Parameter userId: Die Benutzer-ID, für die der Warenkorb geleert wird.
    func clearCart(userId: String) async throws {
        let cartItems = try await store
            .collection("users")
            .document(userId)
            .collection("cart")
            .getDocuments()
        
        for document in cartItems.documents {
            try await document.reference.delete()
        }
    }
    
    // MARK: - Private Firestore Methods
    
    /// Speichert ein Produkt im Warenkorb des angegebenen Benutzers in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt gespeichert wird.
    ///   - cartItem: Das zu speichernde CartItem.
    private func saveToFirestore(userId: String, cartItem: CartItem) async throws {
        try store
            .collection("users")
            .document(userId)
            .collection("cart")
            .document(String(cartItem.product.id))
            .setData(from: cartItem, merge: true)
    }
    
    /// Entfernt ein Produkt aus dem Warenkorb des angegebenen Benutzers in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt entfernt wird.
    ///   - cartItem: Das zu entfernende CartItem.
    private func deleteCartItemFromFirestore(userId: String, cartItem: CartItem) async throws {
        try await store
            .collection("users")
            .document(userId)
            .collection("cart")
            .document(String(cartItem.product.id))
            .delete()
    }
}
