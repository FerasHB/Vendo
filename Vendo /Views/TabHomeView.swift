//
//  HomeView.swift
//  Vendo
//
//  Created by feras hababa on 21.08.24.
//

import SwiftUI

/// Die Hauptansicht, die alle Tabs darstellt und den benutzerdefinierten TabBar einbindet.
struct TabHomeView: View {
    
    // MARK: - Properties
    
    @Binding var selectedTab: Tab 
    @Namespace var animation
    
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoriteManager: FavoritesViewModel
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var ordersManager: OrderViewModel
    @ObservedObject var addressViewModel: AddressViewModel
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                tab.view(
                    cartManager: cartManager,
                    favoriteManager: favoriteManager,
                    viewModel: viewModel,
                    authViewModel: authViewModel,
                    ordersManager: ordersManager, addressViewModel: addressViewModel
                )
                .tag(tab)
            }
        }
        .overlay(
            CustomTabBar(currentTab: $selectedTab, animation: animation,favoriteBadgeCount: favoriteManager.favoriteProducts.count,cartBadgeCount: cartManager.items.count),alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    TabHomeView(
        selectedTab: .constant(.Home),
        cartManager: CartViewModel(),
        favoriteManager: FavoritesViewModel(),
        viewModel: ProductViewModel(category: Category.all),
        authViewModel: AuthViewModel(),
        ordersManager: OrderViewModel(), addressViewModel: AddressViewModel()
    )
}
