//
//  LoginViewModel.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol LoginViewModelInterface {
    var delegate: LoginViewModelDelegate? { get set }
    func login(username: String)
}

protocol LoginViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: LoginViewModelInterface, didLogin client: Client)
}

struct LoginViewModel: LoginViewModelInterface {
    
    weak var delegate: LoginViewModelDelegate?
    private let services: Authenticator = UserServices.shared

    func login(username: String) {
        let client = Client(username: username)
        print("\n\t> login \(client.username)")
        services.login(client: client)
        delegate?.viewModel(self, didLogin: client)
    }
}
