//
//  FavoriteManager.swift
//  Vendo
//
//  Created by feras hababa on 28.08.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class FavoritesViewModel: ObservableObject {
    
 
        
        // MARK: - Published Properties
        @Published var favoriteProducts: [Product] = []
        @Published var errorMessage: String? = nil
       
        
        private let favoritesManager = FavoriteManager.shared
        private let auth = AuthClient.shared
        
        // MARK: - Methods
        
        /// Lädt die Favoriten für den angegebenen Benutzer.
        /// - Parameter userId: Die Benutzer-ID, für die die Favoriten geladen werden.
    func fetchFavorites(userId: String) {
            
            errorMessage = nil
            
            Task {
                do {
                    let favorites = try await favoritesManager.loadFavorites(userId: userId)
                    favoriteProducts = favorites
                } catch {
                    errorMessage = "Fehler beim Laden der Favoriten: \(error.localizedDescription)"
                }
               
            }
        }
        
        func toggleFavorite(userId: String, product: Product) {
            Task {
                if await isFavorite(userId: userId, product: product) {
                    await removeFavorite(userId: userId, product: product)
                } else {
                    await addFavorite(userId: userId, product: product)
                }
            }
        }
        
        func addFavorite(userId: String, product: Product) async {
           
            errorMessage = nil
            
            do {
                try await favoritesManager.addToFavorite(userId: userId, product: product)
                fetchFavorites(userId: userId)
            } catch {
                errorMessage = "Fehler beim Hinzufügen zu den Favoriten: \(error.localizedDescription)"
            }
            
           
        }
        
        func removeFavorite(userId: String, product: Product) async {
           
            errorMessage = nil
            
            do {
                try await favoritesManager.removeFromFavorite(userId: userId, product: product)
                fetchFavorites(userId: userId)
            } catch {
                errorMessage = "Fehler beim Entfernen aus den Favoriten: \(error.localizedDescription)"
            }
            
           
        }
        
        func isFavorite(userId: String, product: Product) async -> Bool {
            do {
                return try await favoritesManager.isFavorite(userId: userId, product: product)
            } catch {
                errorMessage = "Fehler beim Überprüfen des Favoritenstatus: \(error.localizedDescription)"
                return false
            }
        }
    
    }


