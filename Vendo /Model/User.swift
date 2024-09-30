//
//  User.swift
//  Vendo
//
//  Created by feras  hababa  on 05.09.24.
//
import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let username: String?
   
    
    
    let shippingAddress: String?
    let billingAddress: String?
    let city: String?
    let postalCode: String?
    let country: String?
    let isBillingSameAsShipping: Bool?
}
