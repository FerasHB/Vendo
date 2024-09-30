import SwiftUI

struct LoginView: View {
  
    @Binding var currentShowView: String
    @ObservedObject var viewModel: AuthViewModel
    @State private var showSuccessAlert = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Welcome Back!")
                        .font(.largeTitle).bold()
                        .foregroundStyle(Color("kPrimary"))
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(.none)
                    Spacer()
                    if viewModel.email.count != 0 {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("kSecondery"))
                }
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $viewModel.passWord)
                    Spacer()
                    if viewModel.passWord.count != 0 {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("kSecondery"))
                }
                .padding()
                
                Button(action: {
                    withAnimation {
                        self.currentShowView = "signup"
                    }
                }) {
                    Text("Don't have an account?")
                        .foregroundStyle(.black.opacity(0.7))
                }
                
                Spacer()
                Spacer()
                
                Button(action: {
                    viewModel.login()
                    
                   
                    if viewModel.isUserLoggedIn {
                        showSuccessAlert = true
                    }
                    
                }, label: {
                    Text("Log In")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("kPrimary"))
                        )
                        .padding(.horizontal)
                })
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Fehler"),
                        message: Text(viewModel.alertMessage),
                        primaryButton: .default(Text("Yes")),
                        secondaryButton: .cancel(Text("Cancle"))
                    )
                }
                
            }
        }
    }
}

#Preview {
    LoginView(currentShowView: .constant(""), viewModel: AuthViewModel())
}
