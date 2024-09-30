//
//  SearchView.swift
//  Vendo
//
//  Created by feras  hababa  on 02.09.24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var selectedCategory: Category = .all
    @StateObject private var viewModel = SearchViewModel()
    @ObservedObject var favoirtesManager: FavoritesViewModel
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search...", text: $viewModel.userInput)
                        
                        
                       .onChange(of: viewModel.userInput) {
                            viewModel.searchProducts()
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
                .padding(.top, 16)
                
                
                CustomCategoryBar()
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                // Product List or Loading/Error State
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 50)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 50)
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewModel.userInput.isEmpty ? viewModel.products : viewModel.filterdProducts){ product in
                                
                                
                                NavigationLink(destination: ProductDetailsView(product: product, cartManager: cartManager, favoriteManager: favoirtesManager, authViewModel: authViewModel)) {
                                    ProductRow(product: product)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, 5)
                    }
                }
                
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Search", displayMode: .inline)
            .onAppear {
                viewModel.fetchProducts(for: .all)
            }
        }
    }
    
    
    // Custom Category Bar
    @ViewBuilder
    func CustomCategoryBar() -> some View {
        HStack(spacing: 3) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(selectedCategory == category ? .white : Color("kPrimary"))
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if selectedCategory == category {
                            Capsule()
                                .fill( Color("kPrimary"))
                                .matchedGeometryEffect(id: "CATEGORY", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            selectedCategory = category
                            viewModel.fetchProducts(for: category)
                            
                        }
                    }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    SearchView(favoirtesManager: FavoritesViewModel(), cartManager: CartViewModel(), authViewModel: AuthViewModel())
}
