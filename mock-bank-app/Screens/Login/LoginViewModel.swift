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
    func viewModeln(_ viewModel: LoginViewModelInterface, didLogin client: Client)
}

struct LoginViewModel: LoginViewModelInterface {
    
    weak var delegate: LoginViewModelDelegate?
    private let services: LoginServices = MockServices.shared

    func login(username: String) {
        let client = Client(username: username)
        print("> login \(client.username)")
        do {
            if services.getRegistrationStatus(for: client) == .registered {
                services.login(client: client)
            } else {
                services.register(client: client)
            }
            
            delegate?.viewModeln(self, didLogin: client)
        } catch {
            // TODO: handle errors
        }
    }
}
