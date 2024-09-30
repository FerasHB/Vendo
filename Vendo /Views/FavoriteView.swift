//
//  FavoriteView.swift
//  Vendo
//
//  Created by feras  hababa  on 28.08.24.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoritesManager: FavoritesViewModel
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                if favoritesManager.favoriteProducts.count > 0 {
                    ScrollView {
                        ForEach(favoritesManager.favoriteProducts, id: \.id) { product in
                            NavigationLink(destination: ProductDetailsView(product: product, cartManager: cartManager, favoriteManager: favoritesManager, authViewModel: authViewModel)) {
                                CartFavoriteView(cartManager: cartManager, favoriteManager: favoritesManager, authViewModel: authViewModel, cartItem: CartItem(product: product, quantity: 0))
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "heart.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Text("Your Favorites is Empty")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            .navigationTitle("Your Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let userId = authViewModel.user?.uid {
                    favoritesManager.fetchFavorites(userId: userId)
                }
            }
            
        }
    }
    
}

#Preview {
    FavoriteView(favoritesManager: FavoritesViewModel(), cartManager: CartViewModel(), authViewModel: AuthViewModel())
}
