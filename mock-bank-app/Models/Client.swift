//
//  Client.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

class Client {
    var username: String
    var balance: Int
    
    init(username: String = "", balance: Int = 0) {
        self.username = username
        self.balance = balance
    }
}

extension Client: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
        hasher.combine(balance)
    }
}

extension Client: Equatable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        lhs.username == rhs.username
    }
}
