//
//  APIClient.swift
//  Vendo
//
//  Created by feras hababa on 03.09.24.
//

import Foundation

/// Ein Singleton-Klassenobjekt, das für API-Anfragen verwendet wird.
class APIClient {
    
    // MARK: - Singleton Instance
    
    static let shared = APIClient()
    
    // MARK: - Methods
    
    /// Führt eine asynchrone API-Anfrage aus und lädt die Daten basierend auf den angegebenen Parametern.
    /// - Parameters:
    ///   - scheme: Das URL-Schema (z.B. "https").
    ///   - host: Der Hostname der API.
    ///   - path: Der Pfad der API-Anfrage.
    ///   - header: Optionaler Header für die API-Anfrage (z.B. API-Schlüssel).
    ///   - method: Die HTTP-Methode (z.B. "GET" oder "POST"). Standard ist "GET".
    ///   - userInput: Benutzerdefinierte Eingaben, die als Parameter gesendet werden.
    ///   - apiKey: Optionaler API-Schlüssel für Authentifizierung.
    ///   - Returns: Decodierte Daten vom Typ T.
    ///   - Throws: Fehler, die bei der API-Anfrage auftreten können.
    func loadData<T: Codable>(
        scheme: String,
        host: String,
        path: String,
        header: String? = nil,
        method: String? = nil,
        userInput: String? = nil,
        apiKey: String? = nil
    ) async throws -> T? {
        
        // Erstellen der URL-Komponenten
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: userInput)
        ]
        
        // Überprüfen, ob die URL valide ist
        guard let url = urlComponents.url else {
            throw ApiErrors.invalidUrl
        }
        
        // Hinzufügen von Headern, falls vorhanden
        var headers: [String: String] = [:]
        if let header = header, let apiKey = apiKey {
            headers = [
                header: apiKey
            ]
        }
        
        // Erstellen der URL-Anfrage
        var request = URLRequest(url: url)
        request.httpMethod = method ?? "GET"
        request.allHTTPHeaderFields = headers
        
        // Ausführen der Anfrage
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Überprüfen des Statuscodes
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw ApiErrors.unknownError
        }
        
        // Statuscode auswerten
        switch statusCode {
        case 200:
            // Rohes JSON zur Debugging-Zwecken drucken
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            // Versuch, die Daten zu decodieren
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Decodierungsfehler: \(error)")
                throw ApiErrors.decodingError
            }
            
        case 400:
            throw ApiErrors.badResponse
        case 401:
            throw ApiErrors.authenticationMissing
        case 404:
            throw ApiErrors.notFound
        case 429:
            throw ApiErrors.tooManyRequests
        default:
            throw ApiErrors.unknownError
        }
    }
}
