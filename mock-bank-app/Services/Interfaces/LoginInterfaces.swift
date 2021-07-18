//
//  LoginInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol Authenticator {
    func login(client: Client)
}
