//
//  ViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    private var viewModel: LoginViewModelInterface = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func didTapLogin() {
        // TODO: Toggle login button
        let username = usernameTextField.text ?? ""
        viewModel.login(username: username)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func viewModeln(_ viewModel: LoginViewModelInterface, didLogin client: Client) {
        print("Hello, \(client.username)!")
        print("Your balance is \(client.balance).")
        
        // TODO: navigate to main screen
    }
}
