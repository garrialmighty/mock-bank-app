//
//  ApiService.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

final class ApiService {
    static let shared = ApiService()
    
    // update when backend is available
    private let baseURL = URL(string: "")
    
    private init() {}
}

// Move these to the specific interface declaration swift files
// in the event the file becomes too large
// MARK: - Authenticator
extension ApiService: Authenticator {
    func login(client: Client) {
    }
}

// MARK: - Registrator
extension ApiService: Registrator {
    func getRegistrationStatus(for client: Client) -> RegistrationStatus {
        return .registered
    }
    
    func register(client: Client) {
    }
}
