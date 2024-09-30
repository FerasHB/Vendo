//
//  CartItem.swift
//  Vendo
//
//  Created by feras  hababa  on 09.09.24.
//

import Foundation
import FirebaseFirestore


struct CartItem:Codable,Identifiable {
    @DocumentID var id: String?
    var product: Product
    var quantity: Int
    
    var total: Double?
    var createdAt: Date?
      
  
    
}
