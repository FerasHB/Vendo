//
//  AuthViewModel.swift
//  Vendo
//
//  Created by feras hababa on 10.09.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// ViewModel für die Authentifizierung.
/// Verwaltet die Anmeldung, Registrierung und das Löschen von Benutzerkonten.
@MainActor
class AuthViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private let repository = AuthClient.shared
    private let store = FirebaseManager.shared
    
    // MARK: - Published Properties
    
    @Published var email = ""
    @Published var passWord = ""
    @Published var username = ""
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var isLoginMode: Bool = false
    @Published var user: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // MARK: - Initializer
    
    /// Initialisiert das AuthViewModel und lädt den aktuellen Benutzer.
    init() {
        user = repository.getCurrentUser()
    }
    
    // MARK: - Computed Properties
    
    /// Überprüft, ob der Benutzer eingeloggt ist.
    var isUserLoggedIn: Bool {
        return user != nil
    }
    
    // MARK: - Methods
    
    /// Führt die Anmeldung durch.
    /// Setzt bei Erfolg den aktuellen Benutzer, zeigt bei Fehlern eine Fehlermeldung an.
    func login() {
        Task {
            do {
                user = try await repository.logIn(email: email, password: passWord, username: username)
            } catch let error as NSError {
                if error.code == AuthErrorCode.userNotFound.rawValue {
                    alertMessage = "Kein Konto gefunden. Möchten Sie sich registrieren?"
                } else {
                    alertMessage = "Fehler bei der Anmeldung: \(error.localizedDescription)"
                }
                showAlert = true
            }
        }
    }
    
    /// Führt die Registrierung durch.
    /// Erstellt bei Erfolg einen neuen Benutzer und speichert ihn in Firestore.
    func register() {
        Task {
            do {
                user = try await repository.register(email: email, password: passWord, username: username)
                guard let user else { return }

                try store.createUser(id: user.uid, email: email, name: username)
                    username = username
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Meldet den Benutzer ab.
    func logout() {
        do {
            try repository.logout()
            self.user = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Löscht das Benutzerkonto.
    func deleteAccount() {
        Task {
            do {
                try await repository.deleteAccount()
                user = nil
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserData() {
        guard let currentUser = user else { return }
        
        Task {
            do {
                if let userData = try await FirebaseManager.shared.fetchUser(id: currentUser.uid) {
                    username = userData.username ?? "User"
                } else {
                    print("User not found in Firestore")
                }
            } catch {
                print("Error fetching user data: \(error.localizedDescription)")
            }
        }
    }
}
