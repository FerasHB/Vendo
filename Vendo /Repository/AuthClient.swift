//
//  AuthClient.swift
//  Vendo
//
//  Created by feras hababa on 05.09.24.
//

import Foundation
import FirebaseAuth

/// Ein Singleton-Klassenobjekt zur Verwaltung von Authentifizierungsvorgängen.
class AuthClient {
    
    // MARK: - Singleton Instance
    
    static let shared = AuthClient()
    
    // MARK: - Private Properties
    
    private let auth = Auth.auth()
    
    
  
    
    // MARK: - Methods
    
    /// Gibt den aktuell angemeldeten Benutzer zurück.
    /// - Returns: Der aktuell angemeldete `FirebaseAuth.User`, falls vorhanden.
    func getCurrentUser() -> FirebaseAuth.User? {
        return auth.currentUser
    }
    
    /// Führt die Anmeldung mit E-Mail und Passwort durch.
    /// - Parameters:
    ///   - email: Die E-Mail-Adresse des Benutzers.
    ///   - password: Das Passwort des Benutzers.
    ///   - username: Der Benutzername (nicht benötigt für Firebase, aber für die App evtl. wichtig).
    /// - Returns: Der angemeldete `FirebaseAuth.User`.
    func logIn(email: String, password: String, username: String) async throws -> FirebaseAuth.User {
        let result = try await auth.signIn(withEmail: email, password: password)
        return result.user
    }
    
    /// Führt die Registrierung eines neuen Benutzers durch.
    /// - Parameters:
    ///   - email: Die E-Mail-Adresse des Benutzers.
    ///   - password: Das Passwort des Benutzers.
    ///   - username: Der Benutzername (wird für Firebase nicht direkt verwendet, kann aber in der App relevant sein).
    /// - Returns: Der registrierte `FirebaseAuth.User`.
    func register(email: String, password: String, username: String) async throws -> FirebaseAuth.User {
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user
    }
    
    /// Meldet den Benutzer ab.
    /// - Throws: Gibt einen Fehler zurück, falls das Abmelden fehlschlägt.
    func logout() throws {
        try auth.signOut()
    }
    
    /// Löscht das Benutzerkonto des aktuell angemeldeten Benutzers.
    /// - Throws: Gibt einen Fehler zurück, falls das Löschen fehlschlägt.
    func deleteAccount() async throws {
        if let user = auth.currentUser {
            try await user.delete()
        }
    }
}
