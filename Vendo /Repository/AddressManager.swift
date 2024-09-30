//
//  AddressManager.swift
//  Vendo
//
//  Created by feras  hababa  on 25.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AddressManager {
    
    // Singleton-Instanz, um den Manager überall verwenden zu können
    static let shared = AddressManager()
    
    // Firestore-Instanz
    private let store = Firestore.firestore()
    
    // MARK: - Methods
    
    /// Lädt die Adresse des Benutzers aus Firestore.
    /// - Parameter userId: Die Benutzer-ID, für die die Adresse geladen wird.
    /// - Returns: Ein Dictionary mit den Adressdaten.
    func loadAddress(userId: String) async throws -> [String: Any] {
        let document = try await store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .getDocument()
        
        guard let data = document.data() else {
            throw ApiErrors.notFound
        }
        return data
    }
    
    /// Speichert oder aktualisiert die Adresse des Benutzers in Firestore.
    /// - Parameters:
    ///   - userId: Die Benutzer-ID, für die die Adresse gespeichert wird.
    ///   - addressData: Das Dictionary mit den Adressdaten.
    func saveAddress(userId: String, addressData: [String: Any]) async throws {
        try await store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .setData(addressData, merge: true)
    }
    
    /// Löscht die Adresse des Benutzers aus Firestore.
    /// - Parameter userId: Die Benutzer-ID, für die die Adresse gelöscht wird.
    func deleteAddress(userId: String) async throws {
        try await store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .delete()
    }
}


