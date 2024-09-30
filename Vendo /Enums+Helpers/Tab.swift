//
//  Tab.swift
//  Vendo
//
//  Created by feras hababa on 21.08.24.
//

import SwiftUI

/// Enum, das die verschiedenen Tabs in der Anwendung darstellt.
enum Tab: String, CaseIterable {
    case Home = "house"
    case Search = "magnifyingglass.circle"
    case Favorite = "heart"
    case Cart = "cart"
    case Profile = "person"
    
    // MARK: - Tab Name
    
    /// Gibt den Namen des Tabs basierend auf dem Fall zurück.
    var tabName: String {
        switch self {
        case .Home: return "Home"
        case .Search: return "Suche"
        case .Favorite: return "Favoriten"
        case .Cart: return "Warenkorb"
        case .Profile: return "Profil"
        }
    }
    
    // MARK: - View
    
    /// Gibt die entsprechende View für den ausgewählten Tab zurück.
    /// - Parameters:
    ///   - cartManager: Zuständig für die Verwaltung des Warenkorbs.
    ///   - favoriteManager: Zuständig für die Verwaltung der Favoriten.
    ///   - viewModel: ViewModel zur Verwaltung von Produkten.
    ///   - authViewModel: ViewModel zur Verwaltung der Benutzer-Authentifizierung.
    ///   - ordersManager: Zuständig für die Verwaltung von Bestellungen.
    /// - Returns: Eine SwiftUI-Ansicht (View), die dem jeweiligen Tab entspricht.
     @ViewBuilder
    func view(
        cartManager: CartViewModel,
        favoriteManager: FavoritesViewModel,
        viewModel: ProductViewModel,
        authViewModel: AuthViewModel,
        ordersManager: OrderViewModel,
    addressViewModel: AddressViewModel
    ) -> some View {
        switch self {
        case .Home:
            HomeView(cartManager: cartManager, favoritesManager: favoriteManager, viewModel: viewModel, ordersManager: ordersManager, addressViewModel: addressViewModel, authViewModel: authViewModel)
        case .Search:
            SearchView(favoirtesManager: favoriteManager, cartManager: cartManager, authViewModel: authViewModel)
                
        case .Favorite:
            FavoriteView(favoritesManager: favoriteManager, cartManager: cartManager, authViewModel: authViewModel)
               // .badge(favoriteManager.favoriteProducts.count)
        case .Cart:
            CartView(productViewModel: viewModel, cartviewModel: cartManager, favoriteViewModel: favoriteManager, ordersViewModel: ordersManager, addressViewModel: addressViewModel, authViewModel: authViewModel)
              
        case .Profile:
            ProfileView(viewModel: authViewModel, cartManager: cartManager, ordersManager: ordersManager, addressViewModel: addressViewModel)
        }
    }
}
