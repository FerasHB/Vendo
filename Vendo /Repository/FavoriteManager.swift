//
//  FavoriteManager.swift
//  Vendo
//
//  Created by feras  hababa  on 25.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FavoriteManager {
    
    // Singleton-Instanz, um den Manager überall verwenden zu können
    static let shared = FavoriteManager()
       
       // Firestore-Instanz
       private let store = Firestore.firestore()
       
       // MARK: - Methods
       
       /// Lädt die Favoriten für einen bestimmten Benutzer aus Firestore.
       /// - Parameter userId: Die Benutzer-ID, für den die Favoriten geladen werden.
       /// - Returns: Ein Array von Favoritenprodukten.
       func loadFavorites(userId: String) async throws -> [Product] {
           return try await store
               .collection("users")
               .document(userId)
               .collection("favorites")
               .getDocuments()
               .documents
               .map { try $0.data(as: Product.self) }
       }
       
       /// Fügt ein Produkt zu den Favoriten hinzu und speichert es in Firestore.
       /// - Parameters:
       ///   - userId: Die Benutzer-ID, für die das Produkt hinzugefügt wird.
       ///   - product: Das hinzuzufügende Produkt.
       func addToFavorite(userId: String, product: Product) async throws {
           if !(try await isFavorite(userId: userId, product: product)) {
               try await saveToFirestore(userId: userId, product: product)
           }
       }
       
       /// Entfernt ein Produkt von den Favoriten.
       /// - Parameters:
       ///   - userId: Die Benutzer-ID, für die das Produkt entfernt wird.
       ///   - product: Das zu entfernende Produkt.
       func removeFromFavorite(userId: String, product: Product) async throws {
           try await store
               .collection("users")
               .document(userId)
               .collection("favorites")
               .document(String(product.id))
               .delete()
       }
       
       /// Überprüft, ob ein Produkt in den Favoriten ist.
       /// - Parameters:
       ///   - userId: Die Benutzer-ID, die überprüft wird.
       ///   - product: Das zu überprüfende Produkt.
       /// - Returns: `true`, wenn das Produkt in den Favoriten ist, andernfalls `false`.
       func isFavorite(userId: String, product: Product) async throws -> Bool {
           let document = try await store
               .collection("users")
               .document(userId)
               .collection("favorites")
               .document(String(product.id))
               .getDocument()
           
           return document.exists
       }
       
       /// Speichert ein Produkt in der Favoritenliste des angegebenen Benutzers in Firestore.
       /// - Parameters:
       ///   - userId: Die Benutzer-ID, für die das Produkt gespeichert wird.
       ///   - product: Das zu speichernde Produkt.
       private func saveToFirestore(userId: String, product: Product) async throws {
           try store
               .collection("users")
               .document(userId)
               .collection("favorites")
               .document(String(product.id))
               .setData(from: product, merge: true)
       }
    
    
    
}
