//
//  MaterialEffect.swift
//  Vendo
//
//  Created by feras hababa on 21.08.24.
//

import Foundation
import SwiftUI

/// Struktur, die `UIViewRepresentable` implementiert, um einen Blur-Effekt aus UIKit in SwiftUI darzustellen.
struct MaterialEffect: UIViewRepresentable {
    
    // MARK: - Properties
    
    var style: UIBlurEffect.Style
    
    // MARK: - UIViewRepresentable Methods
    
    /// Erstellt eine `UIVisualEffectView` mit dem angegebenen Blur-Effektstil.
    /// - Parameter context: Der SwiftUI Kontext.
    /// - Returns: Eine `UIVisualEffectView`, die den Blur-Effekt anzeigt.
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    /// Aktualisiert die Ansicht bei Änderungen (derzeit keine Implementierung notwendig).
    /// - Parameters:
    ///   - uiView: Die zu aktualisierende `UIVisualEffectView`.
    ///   - context: Der SwiftUI Kontext.
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
