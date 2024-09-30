//
//  SearchView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//

import SwiftUI

struct SearchHomeView: View {
   
    @Binding var showSearchView: Bool
    var body: some View {
        HStack{

                Image(systemName: "magnifyingglass")
                    .padding()
                    .onTapGesture {
                        showSearchView = true
                    }
                    .background(Color("kSecondery"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
           
            Spacer()
          //  Image(systemName: "camera")
          //      .padding()
          //      .foregroundStyle(.white)
          //      .background(Color("kPrimary"))
          //      .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchHomeView( showSearchView: .constant(true))
}

