//
//  ContentView.swift
//  Vendo
//
//  Created by feras  hababa  on 19.08.24.
//

import SwiftUI
import Firebase


struct ContentView: View {
    
    var body: some View {
        AuthView(viewModel: .init())     
    }
}

#Preview {
    ContentView()
}
