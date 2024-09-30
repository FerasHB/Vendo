//
//  Product.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//

import Foundation

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct Product: Identifiable , Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    var image: String
    let rating: Rating
    
}

