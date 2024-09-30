import SwiftUI

struct WelcomeView: View {
    @State private var isAnimatingStars = false
    @State private var isBagVisible = false
    @State private var isAnimatingBag = false
    @State private var showMoneyAnimation = false
    @State private var navigateToHome = false
    
    @ObservedObject var authViewModel : AuthViewModel
    @ObservedObject var viewModel : ProductViewModel
    @ObservedObject var cartManager : CartViewModel
    @ObservedObject var favoriteManager : FavoritesViewModel
    var body: some View {
        ZStack {
            if navigateToHome {
              
                AuthView( viewModel: authViewModel)
            } else {
                Color("kSecondery")
                    .edgesIgnoringSafeArea(.all)
                
                if isBagVisible {
                    VStack(spacing: 20) {
                        Spacer()
                        
                      
                            .onAppear {
                                isAnimatingBag = true
                            }
                        
                        if showMoneyAnimation {
                            CartRainView()
                                .transition(.scale)
                        }

                        Text("“Welcome in your Online Shop Vendo!”")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .foregroundColor(Color("kPrimary"))

                        Spacer()
                        
                        Button(action: {
                            navigateToHome = true
                        }) {
                            Text("Get Started")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("kPrimary"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .scaleEffect(isAnimatingBag ? 1.1 : 1.0)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                        .repeatForever(autoreverses: true),
                                    value: isAnimatingBag
                                )
                        }
                        .padding(.horizontal, 50)
                        .padding(.bottom, 40)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                showMoneyAnimation = true
                            }
                        }
                    }
                } else {
                    StarExplosionView(isAnimating: $isAnimatingStars)
                        .onAppear {
                            withAnimation(Animation.easeOut(duration: 1.5)) {
                                isAnimatingStars = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    isBagVisible = true
                                }
                            }
                        }
                }
            }
        }
    }
}




#Preview {
    WelcomeView(authViewModel: AuthViewModel(), viewModel: ProductViewModel(category: .all), cartManager: CartViewModel(), favoriteManager: FavoritesViewModel())
}

