//
//  LoginInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

enum RegistrationStatus {
    case registered
    case notRegistered
}

protocol Authenticator {
    func login(client: Client)
}
