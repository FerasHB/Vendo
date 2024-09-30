//
//  ProductViewModel.swift
//  Vendo
//
//  Created by feras hababa on 03.09.24.
//

import Foundation


@MainActor
class ProductViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let apiClient = APIClient.shared
    private let firebaseClient = FirebaseManager()
    private let category: Category
    @Published var productList: [Product] = []
    
    // MARK: - Initializer
    
    /// Initialisiert das ViewModel mit einer Kategorie.
    /// - Parameter category: Die Kategorie der Produkte.
    init(category: Category) {
        self.category = category
    }
    
    // MARK: - Methods
    
    /// Lädt alle Produkte entweder aus der API oder aus Firebase.
    /// Wenn die Firebase-Datenbank leer ist, werden die Produkte gespeichert.
    func getAllProducts() {
        Task {
            do {
                // Produkte von der API laden
                productList = try await apiClient.loadData(
                    scheme: Schemas.https.rawValue,
                    host: Host.ApiHost.rawValue,
                    path: Paths.apiPathAllProducts.rawValue
                ) ?? []
                
               
                if try await firebaseClient.getItems(category: category).isEmpty {
                    
                    try productList.forEach {
                        try firebaseClient.save(produckt: $0)
                        print("Daten gespeichert")
                    }
                }
            } catch {
                // Im Fehlerfall: Produkte aus Firebase laden
                print(error)
                productList = try! await firebaseClient.getItems(category: category)
            }
        }
    }
    
}
