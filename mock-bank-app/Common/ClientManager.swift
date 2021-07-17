//
//  ClientManager.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 18/7/21.
//

import Foundation

final class ClientManager {
    static let shared = ClientManager()
    private init() {}
    
    var loggedInClient = Client()
    
    func displayFinancialStatus() {
        displayRecievables()
        displayBalance()
        displayDebt()
    }
    
    func displayRecievables() {
        DebtMediator.shared.recievable(by: loggedInClient).forEach {
            print("Owing \($0.amount) from \($0.debtor.username).")
        }
    }
    
    func displayDebt() {
        DebtMediator.shared.debts(by: loggedInClient).forEach {
            print("Owing \($0.amount) to \($0.lender.username).")
        }
    }
    
    func displayBalance() {
        print("Your balance is \(loggedInClient.balance).")
    }
}
