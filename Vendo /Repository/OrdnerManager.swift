//
//  OrdnerManager2.swift
//  Vendo
//
//  Created by feras  hababa  on 25.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

/// Manager zur Verwaltung von Bestellungen.
/// Zuständig für das Hinzufügen und Abrufen von Bestellungen aus Firestore.
class OrderManager {
    
    // Singleton-Instanz, um den Manager überall verwenden zu können
    static let shared = OrderManager()
    
    // Firestore-Instanz
    private let store = Firestore.firestore()
    
    // MARK: - Methods
    
    /// Fügt ein Produkt zur Bestellung hinzu und speichert es in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt hinzugefügt wird.
    ///   - cartItem: Das hinzuzufügende Produkt.
    func addToOrder(userId: String, cartItem: CartItem) async throws {
        var order = cartItem
        order.createdAt = Date()  // Setzt das Erstellungsdatum auf das aktuelle Datum
        try await saveToFirestore(userId: userId, product: order)
    }
    
    /// Ruft die Bestellungen des Benutzers aus Firestore ab.
    /// - Parameter userId: Die Benutzer-ID, für die die Bestellungen abgerufen werden.
    /// - Returns: Ein Array von CartItems.
    func fetchOrders(userId: String) async throws -> [CartItem] {
        return try await store
            .collection("users")
            .document(userId)
            .collection("orders")
            .getDocuments()
            .documents
            .compactMap { try? $0.data(as: CartItem.self) }
    }
    
    /// Leert die Bestellungen eines Benutzers.
    /// - Parameter userId: Die Benutzer-ID, für die die Bestellungen gelöscht werden.
    func clearOrders(userId: String) async throws {
        let snapshot = try await store
            .collection("users")
            .document(userId)
            .collection("orders")
            .getDocuments()
        
        for document in snapshot.documents {
            try await document.reference.delete()
        }
    }
    
    // MARK: - Private Firestore Methods
    
    /// Speichert ein Produkt in der Bestellhistorie des Benutzers in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die das Produkt gespeichert wird.
    ///   - product: Das zu speichernde CartItem.
    private func saveToFirestore(userId: String, product: CartItem) async throws {
        try store
            .collection("users")
            .document(userId)
            .collection("orders")
            .document(String(product.id ?? ""))
            .setData(from: product, merge: true)
    }
}

