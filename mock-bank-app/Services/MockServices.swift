//
//  MockServices.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

final class MockServices {
    static let shared = MockServices()
    private var mockedLoggedClient = Client()
}

// MARK: - Authenticator
extension MockServices: Authenticator {
    func login(client: Client) {
        mockedLoggedClient = client
    }
}

// MARK: - Registrator
extension MockServices: Registrator {
    func getRegistrationStatus(for client: Client) -> RegistrationStatus {
        mockedLoggedClient = client
        return .registered
    }
    
    func register(client: Client) {
    }
}

// MARK: - ProfileFetcher
extension MockServices: ProfileFetcher {
    func getProfile() -> Client {
        mockedLoggedClient
    }
}
