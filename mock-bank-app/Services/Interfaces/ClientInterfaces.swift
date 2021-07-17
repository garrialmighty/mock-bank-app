//
//  ProfileInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol ProfileFetcher {
    func getProfile() -> Client
}

protocol RecipientFetcher {
    func fetchRecipientClients() -> [Client]
}
