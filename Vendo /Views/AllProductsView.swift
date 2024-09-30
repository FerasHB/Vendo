//
//  AllProductsView.swift
//  Vendo
//
//  Created by feras  hababa  on 26.08.24.
//

import SwiftUI

struct AllProductsView: View {
    @ObservedObject var viewModel : ProductViewModel
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoritesManager: FavoritesViewModel
    @ObservedObject var orderManager: OrderViewModel
    @ObservedObject var authViewModel: AuthViewModel

    var column = [GridItem(.adaptive(minimum: 160), spacing: 25)]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column, spacing: 8) {
                    ForEach(viewModel.productList, id: \.id) { product in
                   
                        NavigationLink {
                            ProductDetailsView(product: product, cartManager: cartManager, favoriteManager: favoritesManager, authViewModel: authViewModel)
                        } label: {
                            ProductCartView(cartManager: cartManager, favoritesManager: favoritesManager, orderManager: orderManager, authViewModel: authViewModel, product: product)
                            
                            
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle(Text("All Products"))
            
        }
        .onAppear{
            viewModel.getAllProducts()
            if let userId = authViewModel.user?.uid {
                favoritesManager.fetchFavorites(userId: userId)
            }
            
        }
    }
}

#Preview {
    AllProductsView(viewModel: ProductViewModel(category: Category.all), cartManager: CartViewModel(), favoritesManager: FavoritesViewModel(), orderManager: OrderViewModel(), authViewModel: AuthViewModel())
}
