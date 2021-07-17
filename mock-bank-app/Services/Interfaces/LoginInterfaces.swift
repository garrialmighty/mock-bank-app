//
//  LoginInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

typealias LoginServices = Authenticator & Registrator

enum RegistrationStatus {
    case registered
    case notRegistered
}

protocol Authenticator {
    func login(client: Client)
}

protocol Registrator {
    func getRegistrationStatus(for client: Client) -> RegistrationStatus
    func register(client: Client)
}
