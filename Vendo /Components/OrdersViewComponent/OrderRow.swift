//
//  OrderRow.swift
//  Vendo
//
//  Created by feras  hababa  on 22.09.24.
//
import SwiftUI

struct OrderRow: View {
    let order: CartItem
    
    var body: some View {
        HStack(spacing: 20) {
            
            AsyncImage(url: URL(string: order.product.image)) { image in
                image
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(order.product.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                
                Text("Preis: \(order.product.price * Double(order.quantity), specifier: "%.2f") €")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                if let createdAt = order.createdAt {
                    Text("Order Date: \(dateFormatter.string(from: createdAt))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(12)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    OrderRow(order: CartItem(
        id: "2",
        product: Product(
            id: 2,
            title: "Wireless Headphones",
            price: 99.99,
            description: "High-quality wireless headphones with noise cancellation and long battery life.",
            category: "Electronics",
            image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
            rating: Rating(rate: 4.5, count: 234)
        ),
        quantity: 1,
        total: 99.99,
        createdAt: Date()
    ))
}
