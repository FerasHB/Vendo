//
//  ProfileView.swift
//  Vendo
//
//  Created by feras hababa on 02.09.24.
//
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: AuthViewModel
    @ObservedObject var cartManager: CartViewModel
    @ObservedObject var ordersManager: OrderViewModel
    @ObservedObject var addressViewModel: AddressViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showLogoutAlert = false
    @State private var showDeleteAccountAlert = false
    @State private var isOrdersViewPresented = false
    @State private var isPrivacyPolicyViewPresented = false
    @State private var isTermsConditionsViewPresented = false
    @State private var isAddressInputViewPresented = false
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView{
                
                VStack(spacing: 10) {
                    
                    VStack(spacing: 10) {
                        
                        Text("My Profile")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("kPrimary"))
                        
                        Text("Hello \(viewModel.username) 👋🏻")
                            .font(.headline)
                        Text("Your Email: \( viewModel.user?.email ?? "")")
                            .foregroundColor(.black)
                            .font(.title3).bold()
                            
                    }
                    .padding(.vertical, 20)
                    
                  
                    
                    VStack(spacing: 10) {
                        SectionHeader(title: "Orders")
                        
                        ProfileRow(icon: "clock.fill", title: "Order History", color: .gray) {
                            isOrdersViewPresented = true
                        }
                        ProfileRow(icon: "house.fill", title: "Address Information", color: .purple) {
                            isAddressInputViewPresented = true
                        }
                        .navigationDestination(isPresented: $isAddressInputViewPresented) {
                            AddressInputView(addressManager: addressViewModel)
                        }
                    }
                    
                    .padding(.horizontal)
                  
                    
                    VStack(spacing: 10) {
                        SectionHeader(title: "General")
                        
                        
                        ProfileRow(icon: "lock.fill", title: "Privacy & Policy", color: .green) {
                            isPrivacyPolicyViewPresented = true
                        }
                        .navigationDestination(isPresented: $isPrivacyPolicyViewPresented) {
                            PrivacyPolicyView()
                        }
                        
                        ProfileRow(icon: "doc.text.fill", title: "Terms & Conditions", color: .black) {
                            isTermsConditionsViewPresented = true
                        }
                        .navigationDestination(isPresented: $isTermsConditionsViewPresented) {
                            TermsConditionsView()
                        }
                        
                        
                        
                        
                        
                        SectionHeader(title: "Account")
                        ProfileRow(icon: "arrow.backward.circle.fill", title: "Log Out", color: .blue) {
                            showLogoutAlert = true
                        }
                        .alert(isPresented: $showLogoutAlert) {
                            Alert(
                                title: Text("Sign Out"),
                                message: Text("Are you sure you want to sign out?"),
                                primaryButton: .destructive(Text("Sign Out")) {
                                    viewModel.logout()
                                    presentationMode.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                        ProfileRow(icon: "trash.fill", title: "Delete Account", color: .red) {
                            showDeleteAccountAlert = true
                        }
                        .alert(isPresented: $showDeleteAccountAlert) {
                            Alert(
                                title: Text("Delete Account"),
                                message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                                primaryButton: .destructive(Text("Delete Account")) {
                                    viewModel.deleteAccount()
                                    presentationMode.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .background(Color(UIColor.white))
                .ignoresSafeArea(.all)
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $isOrdersViewPresented) {
                    OrdersView(ordersManager: ordersManager)
                }
                .onAppear {
                        viewModel.fetchUserData()
                }
            }
        }
    }
}


#Preview {
    ProfileView(viewModel: AuthViewModel(), cartManager: CartViewModel(), ordersManager: OrderViewModel(), addressViewModel: AddressViewModel())
}
