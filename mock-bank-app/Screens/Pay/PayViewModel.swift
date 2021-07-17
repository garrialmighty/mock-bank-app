//
//  PayViewModel.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol PayViewModelInterface {
    var delegate: PayViewModelDelegate? { get set }
    func fetchClients()
    func pay(amount: Int)
    
    // Ideally we use a unique id to identify the client
    // instead of using the username
    mutating func selectClientRecipient(_ id: String)
}

protocol PayViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: PayViewModel, didFetch recipients: [String])
    func viewModel(_ viewModel: PayViewModel, didPay client: Client)
}

struct PayViewModel: PayViewModelInterface {
    
    weak var delegate: PayViewModelDelegate?
    private let userServices: RecipientFetcher = UserServices.shared
    private let coreServices: TransferInterface = CoreServices.shared
    private var clients: [Client] = []
    private var recipientId = ""
    
    func fetchClients() {
        let recipients = userServices.fetchRecipientClients()
        delegate?.viewModel(self, didFetch: recipients.map({ $0.username }))
    }
    
    func pay(amount: Int) {
        print("\n\t> pay \(recipientId) \(amount)")
        coreServices.pay(amount: amount, to: recipientId)
    }
    
    mutating func selectClientRecipient(_ id: String) {
        recipientId = id
    }
}
