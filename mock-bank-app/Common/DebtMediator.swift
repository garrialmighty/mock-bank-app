//
//  DebtMediator.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 18/7/21.
//

import Foundation

final class DebtMediator {
    
    static let shared = DebtMediator()
    private var debtList: Set<Debt> = []
    private init() {}
    
    func checkDebtExistence(lender: Client, debtor: Client) -> Bool {
        debtList.first { $0.lender == lender && $0.debtor == debtor } != nil
    }
    
    func debts(by debtor: Client) -> [Debt] {
        debtList.filter { $0.debtor == debtor }
    }
    
    func recievable(by client: Client) -> [Debt] {
        debtList.filter { $0.lender == client }
    }
    
    func recievables(from debtor: Client) -> Debt? {
        debtList.first(where: { $0.debtor == debtor })
    }
    
    func lend(_ amount: Int, from lender: Client, to debtor: Client) {
        if let existingDebt = debtList.first(where: { $0.lender == lender && $0.debtor == debtor }) {
            existingDebt.amount += amount
        } else {
            let debt = Debt(lender: lender, debtor: debtor, amount: abs(amount))
            debtList.insert(debt)
        }
    }
    
    func deductDebt(from debtor: Client, to lender: Client, by amount: Int) {
        let existingDebt = debtList.first(where: { $0.lender == lender && $0.debtor == debtor })
        guard let debt = existingDebt else { return }
        
        if amount >= debt.amount {
            debtList.remove(debt)
        } else {
            debt.amount -= amount
        }
    }
}
