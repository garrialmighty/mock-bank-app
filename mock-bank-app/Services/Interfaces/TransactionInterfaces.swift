//
//  TransactionInterfaces.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol TopupInterface {
    func topup(amount: Int)
}

protocol TransferInterface {
    func pay(amount: Int, to id: String)
}
