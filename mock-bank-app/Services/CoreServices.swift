//
//  CoreServices.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 18/7/21.
//

import Foundation

final class CoreServices {
    static let shared = CoreServices()
    
    private func payDebts(using amount: Int) -> Int {
        var balance = amount
        
        let client = ClientManager.shared.loggedInClient
        for debt in DebtMediator.shared.debts(by: client) {
            var transferAmount = debt.amount
            let canBePaidoff = balance > debt.amount
            if canBePaidoff {
                balance -= debt.amount
            } else {
                transferAmount = balance
                balance = 0
            }
            
            executeTransfer(amount: transferAmount, to: debt.lender)
            DebtMediator.shared.deductDebt(from: client, to: debt.lender, by: transferAmount)
            
            guard balance == 0 else { continue }
            break
        }
        
        return balance
    }
    
    private func executeTransfer(amount: Int, to client: Client) {
        guard amount > 0,
              let recipient = UserServices.shared.registeredUsers.first(where: { $0 == client })
        else { return }
        
        recipient.balance += amount
        print("Transferred \(amount) to \(recipient.username).")
    }
}

// MARK: - TopupInterface
extension CoreServices: TopupInterface {
    func topup(amount: Int) {
        // payoff or reduce debt before topping up amount
        let topupBalance = payDebts(using: amount)
        
        if topupBalance > 0 {
            ClientManager.shared.loggedInClient.balance += topupBalance
            ClientManager.shared.displayBalance()
        }

        ClientManager.shared.displayDebt()
    }
}

// MARK: - TransferInterface
extension CoreServices: TransferInterface {
    func pay(amount: Int, to id: String) {
        var amountToTransfer = amount
        let loggedInClient = ClientManager.shared.loggedInClient
        
        // todo: create protocol abstraction from user services
        guard let recipient = UserServices.shared.registeredUsers.first(where: { $0.username == id })
        else { return }
        
        if let recievable = DebtMediator.shared.recievables(from: recipient) {
            // deduct from recievables before initiating transfer
            var amountToDeduct = recievable.amount
            if recievable.amount >= amountToTransfer {
                amountToDeduct = amountToTransfer
                amountToTransfer = 0
            }
            
            DebtMediator.shared.deductDebt(from: recipient, to: loggedInClient, by: amountToDeduct)
        } else {
            if loggedInClient.balance < amount {
                // Create/update debt if client pays more than available balance...
                let debtAmount = loggedInClient.balance - amount
                DebtMediator.shared.lend(debtAmount, from: recipient, to: loggedInClient)
                
                // wire all remaining balance
                amountToTransfer = loggedInClient.balance
                loggedInClient.balance = 0
            } else {
                // ...otherwise send indicated amount
                loggedInClient.balance -= amount
                amountToTransfer = amount
                
                DebtMediator.shared.deductDebt(from: loggedInClient, to: recipient, by: amount)
            }
        }
        
        executeTransfer(amount: amountToTransfer, to: recipient)
        ClientManager.shared.displayBalance()
        ClientManager.shared.displayDebt()
        ClientManager.shared.displayRecievables()
    }
}
