//
//  URLComponents.swift
//  Vendo
//
//  Created by feras  hababa  on 03.09.24.
//

import Foundation


enum Schemas:String{
    case https = "https"
}

enum Host:String{
    case ApiHost = "fakestoreapi.com"
}

enum Paths:String{
    case apiPathAllProducts = "/products"
    case apiPathCategory = "/products/categories"
    case apiPathProductInCategory = "/products/category/jewelery"

}

enum Methods:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
