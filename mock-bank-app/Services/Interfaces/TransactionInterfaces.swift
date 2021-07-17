//
//  TransactionInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol TopupInterface {
    func topup(amount: Int) -> Int
}

protocol PayInterface {
    func pay(amount: Int, to client: Client)
}
