//
//  ProductCartView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//

import SwiftUI

struct ProductCartView: View {
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoritesManager: FavoritesViewModel
    @ObservedObject var orderManager: OrderViewModel
    @ObservedObject var authViewModel: AuthViewModel
    var product: Product

    var body: some View {
        ZStack {
            Color("kSecondery")
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .frame(width: 175, height: 165)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            ProgressView("Loading...")
                        }
                        
                        Button(action: {
                            if let userId = authViewModel.user?.uid {
                                favoritesManager.toggleFavorite(userId: userId, product: product)
                            }
                        }) {
                            Image(systemName: favoritesManager.favoriteProducts.contains { $0.id == product.id } ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(favoritesManager.favoriteProducts.contains { $0.id == product.id } ? .red: Color.gray)
                                .padding(8)
                        }
                    }
                    
                    Text(product.title)
                        .font(.headline)
                        .padding(.vertical, 1)
                        .foregroundStyle(.black)
                    
                    HStack(spacing: 3) {
                        ForEach(0..<5) { index in
                            Image(systemName: starType(for: index, rating: product.rating.rate))
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("kPrimary"))
                        }
                    }
                    
                    HStack(alignment: .bottom) {
                        Text(String(format: "%.2f", product.price) + "€")
                            .bold()
                            .foregroundStyle(.black)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        Button {
                            cartManager.addToCart(product: product)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundStyle(Color("kPrimary"))
                                .frame(width: 35, height: 35)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(width: 190, height: 285)
        .clipShape(RoundedRectangle(cornerRadius: 15))
       
    }
}

#Preview {
    ProductCartView(cartManager: CartViewModel(), favoritesManager: FavoritesViewModel(), orderManager: OrderViewModel(), authViewModel: AuthViewModel(), product: .init(
        id: 1,
        title: "Wireless Headphones",
        price: 99.99,
        description: "High-quality wireless headphones with noise cancellation and long battery life.",
        category: "Electronics",
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: .init(rate: 4.5, count: 1234)
    ))
}
