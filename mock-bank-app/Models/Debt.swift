//
//  Debt.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 18/7/21.
//

import Foundation

class Debt {
    var amount: Int
    var lender: Client
    var debtor: Client
    
    init(lender: Client, debtor: Client, amount: Int = 0) {
        self.amount = amount
        self.lender = lender
        self.debtor = debtor
    }
}

extension Debt: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
        hasher.combine(lender)
        hasher.combine(debtor)
    }
}

extension Debt: Equatable {
    static func == (lhs: Debt, rhs: Debt) -> Bool {
        lhs.lender == rhs.lender && lhs.debtor == rhs.debtor
    }
}
