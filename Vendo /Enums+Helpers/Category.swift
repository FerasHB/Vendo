//
//  Category.swift
//  Vendo
//
//  Created by feras hababa on 02.09.24.
//

import Foundation

/// Enum, das die verschiedenen Produktkategorien darstellt.
enum Category: String, CaseIterable {
   
    
    
    // MARK: - Kategorien
    
    case all
    case menClothing
    case womenClothing
    case electronics
    case jewelery
    
    // MARK: - Identifiable Protocol
    
    /// Gibt die eindeutige ID der Kategorie zurück.
   // var id: String { self.rawValue }
    
    // MARK: - Properties
    
    /// Gibt den angezeigten Titel der Kategorie zurück.
    var title: String {
        switch self {
        case .all: return "All"
        case .menClothing: return "Men"
        case .womenClothing: return "Women"
        case .electronics: return "Electro"
        case .jewelery: return "Jewelery"
        }
    }
    
    /// Gibt den kategorisierten Namen zurück (aktuell identisch mit `title`).
    var categoryName: String {
        title
    }
    
    /// Gibt den API-Pfad für die jeweilige Kategorie zurück.
    var apiPath: String {
        switch self {
        case .all:
            return Paths.apiPathAllProducts.rawValue
        case .menClothing:
            return "/products/category/men's clothing"
        case .womenClothing:
            return "/products/category/women's clothing"
        case .electronics:
            return "/products/category/electronics"
        case .jewelery:
            return "/products/category/jewelery"
        }
    }
}
