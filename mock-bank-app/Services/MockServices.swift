//
//  UserServices.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

final class UserServices {
    static let shared = UserServices()
    private var mockedLoggedClient = Client()
    private var mockedDB = [
        Client(username: "Bob", balance: 80),
        Client(username: "Alice", balance: 100)
    ]
}

// MARK: - Authenticator
extension UserServices: Authenticator {
    func login(client: Client) {
        mockedLoggedClient = client
        
        if let registeredClient = mockedDB.first(where: { $0 == client }) {
            mockedLoggedClient = registeredClient
        } else {
            mockedDB.append(client)
        }
        print("Hello, \(mockedLoggedClient.username)!")
        
        let indebtted = mockedLoggedClient.indebtted
        if !indebtted.isEmpty {
            indebtted.forEach {
                print("Owing \($0.amount) from \($0.debtor.username).")
            }
        }
        
        print("Your balance is \(mockedLoggedClient.balance).")
    }
}

// MARK: - ProfileFetcher
extension UserServices: ProfileFetcher {
    func getProfile() -> Client {
        mockedLoggedClient
    }
}

// MARK: - RecipientFetcher
extension UserServices: RecipientFetcher {
    func fetchRecipientClients() -> [Client] {
        mockedDB.filter { $0.username != mockedLoggedClient.username }
    }
}
