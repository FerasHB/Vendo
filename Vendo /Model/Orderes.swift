//
//  File.swift
//  Vendo
//
//  Created by feras  hababa  on 17.09.24.
//

import Foundation
import FirebaseFirestore

struct Orderes: Identifiable, Codable {
    @DocumentID var id: String?
        let items: Product
       let total: Double
       let createdAt: Date
       
       var uniqueID: String { id ?? UUID().uuidString }
}
