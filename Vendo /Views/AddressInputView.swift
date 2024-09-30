//
//  AddressInputView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.09.24.
//
import SwiftUI


struct AddressInputView: View {
    @ObservedObject var addressManager: AddressViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showSavedMessage = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Enter Address Information")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .foregroundColor(Color("kPrimary"))
                
                Form {
                    Section(header: Text("Shipping Address").foregroundColor(Color("kPrimary"))) {
                        Picker("Country", selection: $addressManager.selectedCountry) {
                            ForEach(addressManager.countries, id: \.self) { country in
                                Text(country)
                            }
                        }
                        TextField("Street Address", text: $addressManager.shippingAddress)
                            .autocapitalization(.words)
                        
                        TextField("City", text: $addressManager.shippingCity)
                            .autocapitalization(.words)
                        TextField("Postal Code", text: $addressManager.shippingPostalCode)
                            .keyboardType(.numberPad)
                    }
                    
                    Toggle(isOn: $addressManager.isBillingSameAsShipping) {
                        Text("Billing Address is the same as Shipping Address?")
                            .foregroundColor(Color("kPrimary"))
                    }
                    .toggleStyle(.switch)
                    
                    if !addressManager.isBillingSameAsShipping {
                        Section(header: Text("Billing Address").foregroundColor(Color("kPrimary"))) {
                            TextField("Street Address", text: $addressManager.billingAddress)
                                .autocapitalization(.words)
                            TextField("City", text: $addressManager.city)
                                .autocapitalization(.words)
                            TextField("Postal Code", text: $addressManager.postalCode)
                                .keyboardType(.numberPad)
                        }
                    }
                }
                
                Button(action: {
                    addressManager.saveAddress()
                    showSavedMessage = true
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSavedMessage = false
                    }
                }) {
                    if addressManager.isSaving {
                        ProgressView()
                    } else {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("kPrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Address Information")
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
            .overlay(
                
                Group {
                    if showSavedMessage {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("kPrimary"))
                            .frame(width: 250, height: 50)
                            .overlay(
                                Text("Address saved!")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.5), value: showSavedMessage)
                            .padding(.vertical, 300)
                    }
                }, alignment: .bottom 
            )
        }
        .onAppear {
            addressManager.loadAddress()
        }
    }
}

#Preview {
    AddressInputView(addressManager: AddressViewModel())
}
