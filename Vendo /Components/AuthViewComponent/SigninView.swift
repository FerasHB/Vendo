//
//  SigninView.swift
//  Vendo
//
//  Created by feras  hababa  on 19.08.24.
//

import SwiftUI

struct SigninView: View {
 
    @Binding var currentShowView :String
    @ObservedObject var viewModel : AuthViewModel
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            VStack{
                HStack{
                    Text("Create an Account!")
                        .font(.largeTitle).bold()
                        .foregroundStyle(Color("kSecondery"))
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                HStack{
                    Image(systemName: "person")
                    TextField("User Name",text: $viewModel.username)
                    Spacer()
                    if viewModel.username.count != 0{
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                }
                .foregroundStyle(Color("kSecondery"))
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("kSecondery"))
                }
                .padding()
                HStack{
                   Image(systemName: "mail")
                 TextField("Email",text: $viewModel.email)
                       .autocapitalization(.none)
                   Spacer()
                   if viewModel.email.count != 0{
                       Image(systemName: "checkmark")
                           .fontWeight(.bold)
                           .foregroundStyle(.green)
                   }
                }
                .foregroundStyle(Color("kSecondery"))
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("kSecondery"))
                }
                .padding()
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password",text: $viewModel.passWord)
                    Spacer()
                    if viewModel.passWord.count != 0 {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                }
                .foregroundStyle(Color("kSecondery"))
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("kSecondery"))
                }
                .padding()
                Button(action:{ withAnimation{
                    self.currentShowView = "login"
                }}){
                    Text("Aredy have an accounte?")
                        .foregroundStyle(.gray)
                }
                Spacer()
                Spacer()
                Button(action: {
                   
                    viewModel.register()
                }, label: {
                    Text("Create an Account")
                        .foregroundStyle(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("kSecondery"))
                        )
                        .padding(.horizontal)
                })
            }
        }
        
    }
}

#Preview {
    SigninView(currentShowView: .constant(""), viewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
