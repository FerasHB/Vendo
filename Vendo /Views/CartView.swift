//
//  CartView.swift
//  Vendo
//
//  Created by feras hababa on 26.08.24.
//

import SwiftUI

struct CartView: View {
    @State private var showAlert = false
    @State private var showThankYouView = false
    @State private var useSameAddress = true
    @State private var showAddressInputView = false
    
    @ObservedObject var productViewModel: ProductViewModel
    @ObservedObject var cartviewModel: CartViewModel
    @ObservedObject var favoriteViewModel: FavoritesViewModel
    @ObservedObject var ordersViewModel: OrderViewModel
    @ObservedObject var addressViewModel: AddressViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if cartviewModel.items.count > 0 {
                    ScrollView {
                        ForEach(cartviewModel.items, id: \.id) { cartItem in
                            CartProductView(cartManager: cartviewModel, favoriteManager: favoriteViewModel, authViewModel: authViewModel, cartItem: cartItem)
                        }
                        .padding(5)
                        HStack {
                            Text("Your Total is")
                            Spacer()
                            Text(String(format: "%.2f€", cartviewModel.total))
                                .bold()
                        }
                        .padding()
                        
                        if !addressViewModel.shippingAddress.isEmpty && !addressViewModel.shippingCity.isEmpty && !addressViewModel.shippingPostalCode.isEmpty {
                            Text("The product will be delivered to this address:")
                                .font(.headline)
                                .padding(.top)
                            
                            Text("\(addressViewModel.shippingAddress), \(addressViewModel.shippingCity), \(addressViewModel.shippingPostalCode)")
                                .font(.subheadline).bold()
                                .foregroundStyle(Color("kPrimary"))
                                
                            
                            HStack {
                                Text("Use this address?")
                                Spacer()
                                Toggle(isOn: $useSameAddress) {
                                    Text(useSameAddress ? "Yes" : "No")
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color("kPrimary")))
                            }
                            .padding()
                            
                            if !useSameAddress {
                                Button(action: {
                                    showAddressInputView = true
                                }) {
                                    Text("Edit Address")
                                        .font(.body)
                                        .padding(5)
                                        .background(Color("kSecondary"))
                                        .foregroundColor(.blue)
                                        .cornerRadius(5)
                                }
                                .padding(.bottom)
                            }
                        }
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            Text("Checkout")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("kPrimary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Confirm Purchase"),
                                message: Text("Are you sure you want to complete the purchase?"),
                                primaryButton: .default(Text("Yes, Buy")) {
                                    for cartItem in cartviewModel.items {
                                        ordersViewModel.addToOrder(cartItem: cartItem)
                                    }
                                    cartviewModel.clearCart()
                                    showThankYouView = true
                                },
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "cart.badge.minus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Text("Your Cart is Empty")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle(Text("My Cart"))
            .navigationBarTitleDisplayMode(.automatic)
            .padding(.top)
            .onAppear {
                cartviewModel.loadCart()
                addressViewModel.loadAddress()
            }
            .navigationDestination(isPresented: $showThankYouView) {
                ThankYouView(cartManager: cartviewModel)
            }
            .navigationDestination(isPresented: $showAddressInputView) {
                AddressInputView(addressManager: addressViewModel)
            }
        }
    }
}

#Preview {
    CartView(productViewModel: ProductViewModel(category: .all), cartviewModel: CartViewModel(), favoriteViewModel: FavoritesViewModel(), ordersViewModel: OrderViewModel(), addressViewModel: AddressViewModel(), authViewModel: AuthViewModel())
}
