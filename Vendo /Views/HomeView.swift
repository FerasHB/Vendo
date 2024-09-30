//
//  HomeView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoritesManager: FavoritesViewModel
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var ordersManager: OrderViewModel
    @ObservedObject var addressViewModel: AddressViewModel
    @ObservedObject var authViewModel: AuthViewModel

    
    @State private var showSearchView = false  

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(.white)
                    .ignoresSafeArea(edges: .all)

                VStack {
                    AppBar(cartManager: cartManager, viewModel: viewModel, ordersManager: ordersManager, favoriteManager: favoritesManager, addressViewModel: addressViewModel, authViewModel: authViewModel)

                    HStack{
                        SearchHomeView( showSearchView: $showSearchView)
                        Spacer()
                        
                    }
                    ImageSliderView()

                    HStack {
                        Text("New Rivals")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("kPrimary"))
                        Spacer()
                        NavigationLink(destination: AllProductsView(viewModel: viewModel, cartManager: cartManager, favoritesManager: favoritesManager, orderManager: ordersManager, authViewModel: authViewModel)) {
                            Text("Klick for more")
                                .foregroundStyle(Color("kPrimary"))
                            Image(systemName: "circle.grid.2x2.fill")
                                .foregroundStyle(Color("kPrimary"))
                        }
                    }
                    .padding()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.productList, id: \.id) { product in
                                NavigationLink {
                                    ProductDetailsView(product: product, cartManager: cartManager, favoriteManager: favoritesManager, authViewModel: authViewModel)
                                } label: {
                                    ProductCartView(cartManager: cartManager, favoritesManager: favoritesManager, orderManager: ordersManager, authViewModel: authViewModel, product: product)
                                }
                            }
                        }
                    }
                    .padding(8)
                }
            }
           
            .navigationDestination(isPresented: $showSearchView) {
                SearchView(favoirtesManager: favoritesManager, cartManager: cartManager, authViewModel: authViewModel)
            }
        }
        .onAppear {
            cartManager.loadCart()
            viewModel.getAllProducts()
            if let userId = authViewModel.user?.uid {
                favoritesManager.fetchFavorites(userId: userId)
            }
        }
    }
}

#Preview {
    HomeView(cartManager: CartViewModel(), favoritesManager: FavoritesViewModel(), viewModel: ProductViewModel(category: .all), ordersManager: OrderViewModel(), addressViewModel: AddressViewModel(), authViewModel: AuthViewModel())
}
