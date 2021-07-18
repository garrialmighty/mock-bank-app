//
//  PayViewModel.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol PayViewModelInterface {
    var delegate: PayViewModelDelegate? { get set }
    func pay(amount: Int, id: String)
}

protocol PayViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: PayViewModel, didPay client: Client)
}

struct PayViewModel: PayViewModelInterface {
    
    weak var delegate: PayViewModelDelegate?
    private let services: TransferInterface
    private var clients: [Client] = []
    
    init(services: TransferInterface) {
        self.services = services
    }
    
    func pay(amount: Int, id: String) {
        print("\n\t> pay \(id) \(amount)")
        services.pay(amount: amount, to: id)
    }
}
