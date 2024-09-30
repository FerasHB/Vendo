//
//  FirebaseManager.swift
//  Vendo
//
//  Created by feras hababa on 10.09.24.
//

import Foundation
import FirebaseFirestore

/// Ein Singleton-Klassenobjekt zur Verwaltung der Firebase-Operationen.
class FirebaseManager {
    
    // MARK: - Singleton Instance
    
    static let shared = FirebaseManager()
    
    // MARK: - Private Properties
    
    private let store = Firestore.firestore()
    
    // MARK: - Methods
    
    /// Erstellt einen neuen Benutzer in der Firebase-Datenbank.
    /// - Parameters:
    ///   - id: Die eindeutige Benutzer-ID.
    ///   - email: Die E-Mail-Adresse des Benutzers.
    ///   - name: Der Benutzername.
    /// - Throws: Gibt einen Fehler zurück, falls das Speichern fehlschlägt.
    func createUser(id: String, email: String, name: String) throws {
        let user = User(uid: id, email: email, username: name,  shippingAddress: "", billingAddress: "", city: "", postalCode: "", country: "", isBillingSameAsShipping: false)
        try store
            .collection("users")
            .document(id)
            .setData(from: user) { error in
                if let error = error {
                    print("Fehler beim Hinzufügen des Benutzers: \(error.localizedDescription)")
                } else {
                    print("Benutzer erfolgreich hinzugefügt!")
                }
            }
    }
    /// Lädt einen Benutzer aus der Firebase-Datenbank.
    /// - Parameter id: Die Benutzer-ID des Benutzers, den Sie abrufen möchten.
    /// - Returns: Ein `User`-Objekt.
    /// - Throws: Gibt einen Fehler zurück, falls das Abrufen fehlschlägt.
    func fetchUser(id: String) async throws -> User? {
        let document = try await store.collection("users").document(id).getDocument()
        
        if let user = try? document.data(as: User.self) {
            return user
        } else {
            return nil  // If no user data is found, return nil
        }
    }
    
    /// Speichert ein Produkt in der Firebase-Datenbank.
    /// - Parameter produckt: Das zu speichernde Produkt.
    /// - Throws: Gibt einen Fehler zurück, falls das Speichern fehlschlägt.
    func save(produckt: Product) throws {
        try store
            .collection("products")
            .document(String(produckt.id))
            .setData(from: produckt, merge: true)
    }
    
    /// Lädt Produkte aus einer bestimmten Kategorie aus der Firebase-Datenbank.
    /// - Parameter category: Die Kategorie, aus der die Produkte geladen werden sollen.
    /// - Returns: Eine Liste von Produkten aus der angegebenen Kategorie.
    /// - Throws: Gibt einen Fehler zurück, falls das Abrufen fehlschlägt.
    func getItems(category: Category) async throws -> [Product] {
        try await store
            .collection(category.apiPath)
            .getDocuments()
            .documents
            .map { document in
               
                return try document.data(as: Product.self)
            }
    }
}
