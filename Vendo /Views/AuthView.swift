//
//  AuthView.swift
//  Vendo
//
//  Created by feras  hababa  on 19.08.24.
//

import SwiftUI

struct AuthView: View {
    @State var currentViewShowing = "login"
    @ObservedObject var viewModel : AuthViewModel
    var body: some View {
        if currentViewShowing == "login"{
            LoginView(currentShowView: $currentViewShowing, viewModel: viewModel)
                .preferredColorScheme(.light)
        }else{
            SigninView(currentShowView: $currentViewShowing, viewModel: viewModel)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel())
}
