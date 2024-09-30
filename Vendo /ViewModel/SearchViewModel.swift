//
//  SearchViewModel.swift
//  Vendo
//
//  Created by feras hababa on 04.09.24.
//

import Foundation


@MainActor
class SearchViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var isLoading = false
    @Published var products: [Product] = []
    @Published var filterdProducts: [Product] = []
    @Published var errorMessage: String? = nil
    @Published var userInput = ""
    @Published var selectedCategory: Category = .all
    
    // MARK: - Private Properties
    
    private let apiClient = APIClient.shared
    
    // MARK: - Methods
    
    /// Lädt alle Produkte von der API.
    func getAllProducts() {
        Task {
            do {
                // Produkte von der API laden
                products = try await apiClient.loadData(
                    scheme: Schemas.https.rawValue,
                    host: Host.ApiHost.rawValue,
                    path: Paths.apiPathAllProducts.rawValue
                ) ?? []
            } catch {
                // Fehlerbehandlung
                print(error)
            }
        }
    }
    
    /// Lädt Produkte für eine bestimmte Kategorie von der API.
    /// - Parameter category: Die Kategorie, für die Produkte geladen werden sollen.
    func fetchProducts(for category: Category) {
        isLoading = true
        Task {
            do {
                let fetchedProducts: [Product] = try await APIClient.shared.loadData(
                    scheme: Schemas.https.rawValue,
                    host: Host.ApiHost.rawValue,
                    path: category.apiPath
                ) ?? []                
                products = fetchedProducts
            } catch {
               
                errorMessage = "Fehler beim Laden der Produkte: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
    
    /// Filtert die Produkte basierend auf der Benutzereingabe.
    func searchProducts() {
        
        filterdProducts = products.filter { $0.title.localizedCaseInsensitiveContains(userInput)
            
        }
    }
}
