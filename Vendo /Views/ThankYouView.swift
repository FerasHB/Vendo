import SwiftUI

struct ThankYouView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToHome = false
    @ObservedObject var cartManager: CartViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "shippingbox.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("kPrimary"))
            
     
            Text("Thank you for your order!")
                .font(.title).bold()
                .foregroundStyle(Color("kPrimary"))
                .padding(.top, 20)
            
            Text("Your order is now being processed and will be shipped as quickly as possible.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 40)
                .padding(.top, 10)
            
            Spacer()
            Button(action: {
              
                presentationMode.wrappedValue.dismiss()
                    
            }) {
                Text("Continue Shopping")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("kPrimary"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
            }
            
            Spacer(minLength: 50)  
        }
        .navigationTitle("Thank You")
    }
}

#Preview {
    ThankYouView(cartManager: CartViewModel())
}
