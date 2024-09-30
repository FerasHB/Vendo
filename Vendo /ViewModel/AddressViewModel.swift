//
//  AddressManager.swift
//  Vendo
//
//  Created by feras  hababa  on 23.09.24.
//

import Foundation
import FirebaseAuth

@MainActor
class AddressViewModel: ObservableObject {
    
    
    // MARK: - Published Properties
    
    @Published var shippingAddress: String = ""
    @Published var billingAddress: String = ""
    @Published var city: String = ""
    @Published var shippingCity: String = ""
    @Published var postalCode: String = ""
    @Published var shippingPostalCode: String = ""
    @Published var selectedCountry: String = "Germany"
    @Published var countries: [String] = ["Germany", "France", "USA", "Canada"]
    @Published var isBillingSameAsShipping: Bool = false
    @Published var isSaving: Bool = false
    @Published var errorMessage: String? = nil
    
    private let addressManager = AddressManager.shared
    
    /// Lädt die Adresse für den aktuellen Benutzer.
    func loadAddress() {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "Kein Benutzer angemeldet."
            return
        }
        Task {
            do {
                let data = try await addressManager.loadAddress(userId: userId)
             
                updateLocalAddressData(with: data)
            } catch {
                errorMessage = "Fehler beim Laden der Adresse: \(error.localizedDescription)"
            }
        }
    }
    
    /// Speichert oder aktualisiert die Adresse des aktuellen Benutzers.
    /// diese Funktion eine Benutzeradresse, überprüft, ob der Benutzer eingeloggt ist, erstellt die Adressdaten, und versucht, diese asynchron in einer Datenbank ( Firestore) zu speichern.
    func saveAddress() {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "Kein Benutzer angemeldet."
            return
        }
        
        isSaving = true
        
        let addressData: [String: Any] = [
            "shippingAddress": shippingAddress,
            "billingAddress": isBillingSameAsShipping ? shippingAddress : billingAddress,
            "city": city,
            "shippingCity": shippingCity,
            "postalCode": postalCode,
            "shippingPostalCode": shippingPostalCode,
            "country": selectedCountry,
            "isBillingSameAsShipping": isBillingSameAsShipping
        ]
        
        Task {
            do {
                try await addressManager.saveAddress(userId: userId, addressData: addressData)
                isSaving = false
            } catch {
                    errorMessage = "Fehler beim Speichern der Adresse: \(error.localizedDescription)"
                isSaving = false
            }
        }
    }
    
    /// Löscht die Adresse des aktuellen Benutzers.
    func deleteAddress() {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "Kein Benutzer angemeldet."
            return
        }
        
        Task {
            do {
                try await addressManager.deleteAddress(userId: userId)
                clearLocalAddressData()
            } catch {
                errorMessage = "Fehler beim Löschen der Adresse: \(error.localizedDescription)"
            }
        }
    }
    
    // MARK: - Private Helper Methods
    
    /// Aktualisiert die lokalen Adressdaten mit den geladenen Daten aus Firestore.
    /// Diese Methode wird verwendet, um die lokalen Adressdaten auf den aktuellen Stand zu bringen
    private func updateLocalAddressData(with data: [String: Any]) {
        shippingAddress = data["shippingAddress"] as? String ?? ""
        billingAddress = data["billingAddress"] as? String ?? ""
        city = data["city"] as? String ?? ""
        shippingCity = data["shippingCity"] as? String ?? ""
        postalCode = data["postalCode"] as? String ?? ""
        shippingPostalCode = data["shippingPostalCode"] as? String ?? ""
        selectedCountry = data["country"] as? String ?? "Germany"
        isBillingSameAsShipping = data["isBillingSameAsShipping"] as? Bool ?? false
    }
    
    /// Löscht die lokalen Adressdaten nach dem Löschen aus Firestore.
    private func clearLocalAddressData() {
        shippingAddress = ""
        billingAddress = ""
        city = ""
        postalCode = ""
        selectedCountry = "Germany"
        isBillingSameAsShipping = false
    }
}
