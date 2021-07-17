//
//  TopupViewModel.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol TopupViewModelInterface {
    var delegate: TopupViewModelDelegate? { get set }
    func topup(amount: Int)
}

protocol TopupViewModelDelegate: AnyObject {
    func viewModelDidTopup(_ viewModel: TopupViewModel)
}

struct TopupViewModel: TopupViewModelInterface {
    
    weak var delegate: TopupViewModelDelegate?
    private let services: TopupInterface = MockServices.shared
    
    func topup(amount: Int) {
        do {
            print("> topup \(amount)")
            let updatedAmount = services.topup(amount: amount)
            print("Your balance is \(updatedAmount).")
            delegate?.viewModelDidTopup(self)
        } catch {
            // TODO: handle errors
        }
    }
}
