//
//  StarExplosionView.swift
//  Vendo
//
//  Created by feras hababa on 11.09.24.
//

import SwiftUI

/// Eine Ansicht, die eine Animation von explodierenden Sternen (oder Taschen) darstellt.
struct StarExplosionView: View {
    
    // MARK: - Properties
    
    /// Bindet den Animationszustand, um die Bewegung zu steuern.
    @Binding var isAnimating: Bool

    // MARK: - Body
    
    var body: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { index in
                Image("VendoIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("kPrimary"))
                    .opacity(isAnimating ? 0 : 1)
                    .offset(self.starOffset(index: index))  
                    .animation(Animation.easeIn(duration: 1).delay(0.2 * Double(index)), value: isAnimating)
            }
        }
    }

    // MARK: - Private Methods
    
    /// Berechnet den Versatz (Offset) für jedes Bild in der Explosion.
    /// - Parameter index: Der Index des Bildes.
    /// - Returns: Die entsprechende `CGSize`, die den Offset des Bildes bestimmt.
    private func starOffset(index: Int) -> CGSize {
        let distance: CGFloat = 300
        switch index {
        case 0: return isAnimating ? .zero : CGSize(width: -distance, height: -distance)
        case 1: return isAnimating ? .zero : CGSize(width: distance, height: -distance)
        case 2: return isAnimating ? .zero : CGSize(width: -distance, height: distance)
        case 3: return isAnimating ? .zero : CGSize(width: distance, height: distance)
        default: return .zero
        }
    }
}

#Preview {
    StarExplosionView(isAnimating: .constant(.random()))
}
