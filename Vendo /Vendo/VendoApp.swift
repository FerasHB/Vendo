//
//  VendoApp.swift
//  Vendo
//
//  Created by feras  hababa  on 19.08.24.
//

import SwiftUI
import Firebase

@main
struct VendoApp: App {
    @StateObject var favoritesManager = FavoritesViewModel()
    @StateObject var cartManager = CartViewModel()
    @StateObject var viewModel = ProductViewModel(category: .all)
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var ordersManager = OrderViewModel()
    @StateObject var addressViewModel = AddressViewModel()

    @State private var selectedTab: Tab = .Home  
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        print("Firebase wurde konfiguriert")
    }
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isUserLoggedIn {
              
                TabHomeView(selectedTab: $selectedTab, cartManager: cartManager, favoriteManager: favoritesManager, viewModel: viewModel, authViewModel: authViewModel, ordersManager: ordersManager, addressViewModel: addressViewModel)
                  
            } else {
                WelcomeView(authViewModel: authViewModel, viewModel: viewModel, cartManager: cartManager, favoriteManager: favoritesManager)
            }
        }
    }
}
