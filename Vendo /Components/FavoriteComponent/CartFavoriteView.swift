//
//  CartFavoriteVeiw.swift
//  Vendo
//
//  Created by feras  hababa  on 10.09.24.
//
import SwiftUI

struct CartFavoriteView: View {
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoriteManager: FavoritesViewModel
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isShowingSheet = false
    
    var cartItem: CartItem

    var body: some View {
        HStack(spacing: 20) {
            
            AsyncImage(url: URL(string: cartItem.product.image)) { image in
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
            
            VStack(alignment: .leading, spacing: 8) {
                Text(cartItem.product.title)
                    .foregroundColor(Color("kPrimary"))
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                Text(cartItem.product.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(String(format: "%.2f", cartItem.product.price))€")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("kPrimary"))
            }
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    isShowingSheet = true
                }) {
                    Image(systemName: "heart.slash")
                        .foregroundStyle(Color("kPrimary"))
                }
                .confirmationDialog(
                    "Confirm Remove from Favorites",
                    isPresented: $isShowingSheet,
                    titleVisibility: .visible
                ) {
                    Button("Remove") {
                        if let userId = authViewModel.user?.uid {
                            favoriteManager.toggleFavorite(userId: userId, product: cartItem.product)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(12)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("kPrimary"), lineWidth: 1)
        )
    }
    
    
}

#Preview {
    CartFavoriteView(
        cartManager: CartViewModel(),
        favoriteManager: FavoritesViewModel(), authViewModel: AuthViewModel(),
        cartItem: CartItem(
            product: Product(
                id: 2,
                title: "Wireless Headphones",
                price: 99.99,
                description: "Great product",
                category: "Electronics",
                image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                rating: .init(rate: 4.5, count: 100)
            ),
            quantity: 1
        )
    )
}
