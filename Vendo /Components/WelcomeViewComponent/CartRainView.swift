//
//  MoneyRainView.swift
//  Vendo
//
//  Created by feras  hababa  on 11.09.24.
//

import SwiftUI

struct CartRainView: View {
    var body: some View {
        ZStack {
            ForEach(0..<20, id: \.self) { _ in
                Image("VendoIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230, height: 230)
                    .foregroundColor(Color("kPrimary"))
                    .offset(y: -50)
                    .animation(Animation.easeInOut(duration: 2).repeatForever().delay(Double.random(in: 0..<1)), value: UUID())
            }
        }
    }
}
#Preview {
    CartRainView()
}
