//
//  AppBar.swift
//  Vendo
//
//  Created by feras  hababa  on 28.08.24.
//

import SwiftUI

struct AppBar: View {
    @ObservedObject var cartManager: CartViewModel 
    @ObservedObject var viewModel : ProductViewModel
    @ObservedObject var ordersManager : OrderViewModel
    @ObservedObject var favoriteManager : FavoritesViewModel
    @ObservedObject var addressViewModel : AddressViewModel
    @ObservedObject var authViewModel : AuthViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Shop Smarter Not Harder")
                    .font(.title2).bold()
                
                Spacer()
                
                NavigationLink(destination: CartView(productViewModel: viewModel, cartviewModel: cartManager, favoriteViewModel: favoriteManager, ordersViewModel: ordersManager, addressViewModel: addressViewModel, authViewModel: authViewModel)) { 
                    CartButton(numberOfProducts: cartManager.items.count)
                }
            }
            .padding()
        }
    }
}
