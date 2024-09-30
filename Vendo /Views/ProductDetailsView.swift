//
//  ProductDetailsView.swift
//  Vendo
//
//  Created by feras hababa on 26.08.24.
//


import SwiftUI

struct ProductDetailsView: View {
    var product: Product
    @State private var itemCount: Int = 1
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var favoriteManager: FavoritesViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.white
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .ignoresSafeArea(edges: .top)
                                .frame(height: 390)
                        } placeholder: {
                            ProgressView("Loading...")
                        }
                        
                      
                        Button(action: {
                            if let userId = authViewModel.user?.uid {
                                favoriteManager.toggleFavorite(userId: userId, product: product)
                            }
                        }) {
                            if (authViewModel.user?.uid) != nil {
                                Image(systemName: favoriteManager.favoriteProducts.contains(where: { $0.id == product.id }) ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(favoriteManager.favoriteProducts.contains(where: { $0.id == product.id }) ? .red : .gray)
                                    .padding(8)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(product.title)
                                .font(.title2.bold())
                                
                            Spacer()
                            Text(String(format: "%.2f", product.price) + "€")
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.horizontal)
                                .background(Color("kSecondery"))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.vertical)
                        
                        HStack {
                            HStack(spacing: 10) {
                                ForEach(0..<5) { index in
                                    Image(systemName: starType(for: index, rating: product.rating.rate))
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("kPrimary"))
                                }
                                Text("Rating: \(product.rating.rate, specifier: "%.1f") / 5.0")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical)
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if itemCount > 1 {
                                        itemCount -= 1
                                    }
                                }, label: {
                                    Image(systemName: "minus.square")
                                        .foregroundStyle(Color("kPrimary"))
                                })
                                .disabled(itemCount <= 1)
                                
                                Text("\(itemCount)")
                                
                                Button(action: {
                                    itemCount += 1
                                }, label: {
                                    Image(systemName: "plus.square.fill")
                                        .foregroundStyle(Color("kPrimary"))
                                })
                            }
                        }
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text(product.description)
                        
                        Spacer()
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Count:")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                Text("\(product.rating.count)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Colors:")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                HStack {
                                    ColoerDotView(color: .blue)
                                    ColoerDotView(color: .black)
                                    ColoerDotView(color: .green)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical)
                        
                        Button(action: {
                            cartManager.addToCart(product: product)
                        }) {
                            Text("Add to Cart")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("kPrimary"))
                            
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .offset(y: -30)
                }
            }
        }
    }
    
    func starType(for index: Int, rating: Double) -> String {
        return index < Int(rating) ? "star.fill" : "star"
    }
}


#Preview {
    ProductDetailsView(product: .init(
        id: 1,
        title: "Wireless Headphones",
        price: 99.99,
        description: "High-quality wireless headphones with noise cancellation and long battery life.",
        category: "Electronics",
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: .init(rate: 4.5, count: 1234)
    ), cartManager: CartViewModel(), favoriteManager: FavoritesViewModel(), authViewModel: AuthViewModel())
}


struct ColoerDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 25, height: 25)
            .clipShape(Circle())
    }
}
