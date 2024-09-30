//
//  CartButton.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//

import SwiftUI

struct CartButton: View {
    var numberOfProducts: Int
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart.fill")
                .foregroundStyle(.black)
                .padding(5)
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
        }
    }
}

#Preview {
    CartButton(numberOfProducts: 9)
}
