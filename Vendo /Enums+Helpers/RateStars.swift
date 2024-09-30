//
//  RateStars.swift
//  Vendo
//
//  Created by feras hababa on 04.09.24.
//

import Foundation

/// Bestimmt den Typ des Sterns basierend auf dem Index und der Bewertung.
/// - Parameters:
///   - index: Der aktuelle Sternindex (beginnend bei 0).
///   - rating: Die Bewertung als `Double`, die zwischen 0 und 5 liegt.
/// - Returns: Ein String, der den Namen des Symbols für den Stern (voll, halb oder leer) darstellt.
func starType(for index: Int, rating: Double) -> String {
    if rating >= Double(index) + 1 {
        return "star.fill" // Voller Stern
    } else if rating > Double(index) && rating < Double(index) + 1 {
        return "star.leadinghalf.filled" // Halb gefüllter Stern
    } else {
        return "star" // Leerer Stern
    }
}
