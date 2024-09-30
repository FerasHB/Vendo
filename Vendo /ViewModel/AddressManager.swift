//
//  AddressManager.swift
//  Vendo
//
//  Created by feras  hababa  on 23.09.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import MapKit

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
    
    // MARK: - Private Properties
    private var store = Firestore.firestore()
    private var userId: String?
    

    
    // MARK: - Address Management
    
    /// Lädt die Adresse des aktuellen Benutzers aus Firestore
    func loadAddress() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .getDocument { document, error in
                if let error = error {
                    print("Fehler beim Laden der Adresse: \(error.localizedDescription)")
                    return
                }
                
                if let document = document, document.exists {
                    let data = document.data()
                    self.shippingAddress = data?["shippingAddress"] as? String ?? ""
                    self.billingAddress = data?["billingAddress"] as? String ?? ""
                    self.city = data?["city"] as? String ?? ""
                    self.shippingCity = data?["shippingCity"] as? String ?? ""
                    self.postalCode = data?["postalCode"] as? String ?? ""
                    self.shippingPostalCode = data?["shippingPostalCode"] as? String ?? ""
                    self.selectedCountry = data?["country"] as? String ?? "Germany"
                    self.isBillingSameAsShipping = data?["isBillingSameAsShipping"] as? Bool ?? false
                }
            }
    }
    
    /// Speichert oder aktualisiert die Adresse des Benutzers in Firestore
    func saveAddress() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isSaving = true
        
        // Wenn Rechnungsadresse mit Versandadresse identisch ist
        if isBillingSameAsShipping {
            billingAddress = shippingAddress
        }
        
        let addressData: [String: Any] = [
            "shippingAddress": shippingAddress,
            "billingAddress": billingAddress,
            "city": city,
            "shippingCity": shippingCity,
            "postalCode": postalCode,
            "shippingPostalCode": shippingPostalCode,
            "country": selectedCountry,
            "isBillingSameAsShipping": isBillingSameAsShipping
        ]
        
        store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .setData(addressData, merge: true) { error in
                self.isSaving = false
                if let error = error {
                    print("Fehler beim Speichern der Adresse: \(error.localizedDescription)")
                } else {
                    print("Adresse erfolgreich gespeichert.")
                }
            }
    }
    
    /// Löscht die Adresse des Benutzers aus Firestore
    func deleteAddress() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        store
            .collection("users")
            .document(userId)
            .collection("address")
            .document("addressInfo")
            .delete { error in
                if let error = error {
                    print("Fehler beim Löschen der Adresse: \(error.localizedDescription)")
                } else {
                    print("Adresse erfolgreich gelöscht.")
                    self.clearLocalAddressData()
                }
            }
    }
    
    // MARK: - Private Helper Methods
    
    /// Löscht die lokale Adressdaten nach dem Löschen aus Firestore
    private func clearLocalAddressData() {
        shippingAddress = ""
        billingAddress = ""
        city = ""
        postalCode = ""
        selectedCountry = "Germany"
        isBillingSameAsShipping = false
       
    }
}
