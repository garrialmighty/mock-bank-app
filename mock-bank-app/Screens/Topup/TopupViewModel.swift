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
    private let services: TopupInterface
    
    init(services: TopupInterface) {
        self.services = services
    }
    
    func topup(amount: Int) {
        print("\n\t> topup \(amount)")
        services.topup(amount: amount)
        delegate?.viewModelDidTopup(self)
    }
}
