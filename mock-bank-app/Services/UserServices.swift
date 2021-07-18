//
//  UserServices.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

final class UserServices {
    static let shared = UserServices()
    var registeredUsers: [Client] = []
}

// MARK: - Authenticator
extension UserServices: Authenticator {
    func login(client: Client) {
        ClientManager.shared.loggedInClient = client
        
        if let registeredClient = registeredUsers.first(where: { $0 == client }) {
            ClientManager.shared.loggedInClient = registeredClient
        } else {
            registeredUsers.append(client)
        }
        
        print("Hello, \(ClientManager.shared.loggedInClient.username)!")
        ClientManager.shared.displayFinancialStatus()
    }
}

// MARK: - ProfileFetcher
extension UserServices: ProfileFetcher {
    func getProfile() -> Client {
        ClientManager.shared.loggedInClient
    }
}

// MARK: - RecipientFetcher
extension UserServices: RecipientFetcher {
    func fetchRecipientClients() -> [Client] {
        registeredUsers.filter { $0 != ClientManager.shared.loggedInClient }
    }
}
