//
//  ProductRow.swift
//  Vendo
//
//  Created by feras  hababa  on 04.09.24.
//

import Foundation
import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 70, height: 70)
                    .overlay(
                        ProgressView()
                    )
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .lineLimit(1)
                    .font(.headline)
                    .foregroundStyle(Color("kPrimary"))
                Text("\(product.price, specifier: "%.2f")$")
                    .font(.subheadline)
                    .foregroundStyle(Color("kPrimary"))
                
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: starType(for: index, rating: product.rating.rate))
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color("kPrimary"))
                    }
                    
                }
            }
            Spacer()
        }
        
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("kPrimary"), lineWidth: 1)
        )
    }
    
}


#Preview {
    ProductRow(product: .init(
           id: 1,
           title: "Wireless Headphones",
           price: 99.99,
           description: "High-quality wireless headphones with noise cancellation and long battery life.",
           category: "Electronics",
           image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
           rating: .init(rate: 4.5, count: 1234)
       ))
}
