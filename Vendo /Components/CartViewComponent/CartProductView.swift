//
//  CartProductView.swift
//  Vendo
//
//  Created by feras  hababa  on 26.08.24.
//
import SwiftUI



struct CartProductView: View {
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoriteManager: FavoritesViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var isShowingSheet = false
    @State private var isShowingFavoriteDialog = false
    
    var cartItem: CartItem
    

    
    var body: some View {
        HStack(spacing: 20) {
            
            AsyncImage(url: URL(string: cartItem.product.image)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
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
            .onAppear {
                print("Image URL: \(cartItem.product.image)")
            }

            
            VStack(alignment: .leading, spacing: 8) {
                Text(cartItem.product.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                Text("\(String(format: "%.2f", cartItem.product.price * Double(cartItem.quantity)))€")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("kPrimary"))
                Text("Quantity: \(cartItem.quantity)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    isShowingSheet = true
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
                .confirmationDialog(
                    "Confirm Delete",
                    isPresented: $isShowingSheet,
                    titleVisibility: .visible
                ) {
                    Button("Remove") {
                        cartManager.removeFromCart(cartItem: cartItem)
                    }
                    Button("Cancel", role: .cancel) {}
                }
                
                Button(action: {
                    isShowingFavoriteDialog = true
                }) {
                    Image(systemName: "heart")
                        .foregroundStyle(Color("kPrimary"))
                }
                .confirmationDialog(
                    "Add to Favorites?",
                    isPresented: $isShowingFavoriteDialog,
                    titleVisibility: .visible
                ) {
                    Button("Add") {
                        Task{
                            await  moveToFavorite()
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
       
        .padding()
        .background(Color(.white))
        .cornerRadius(5)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
       // .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("kPrimary"), lineWidth: 1)
        )
    }
    
    private func moveToFavorite() async {
        cartManager.removeFromCart(cartItem: cartItem)
        if let userId = authViewModel.user?.uid {
            await favoriteManager.addFavorite(userId: userId, product: cartItem.product)
        }
        
    }
}

#Preview {
    CartProductView(
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
