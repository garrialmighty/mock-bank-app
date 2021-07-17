//
//  MockServices.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

final class MockServices {
    static let shared = MockServices()
}

// MARK: - Authenticator
extension MockServices: Authenticator {
    func login(client: Client) {
    }
}

// MARK: - Registrator
extension MockServices: Registrator {
    func getRegistrationStatus(for client: Client) -> RegistrationStatus {
        return .registered
    }
    
    func register(client: Client) {
    }
}
