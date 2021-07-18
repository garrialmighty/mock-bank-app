//
//  ViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var usernameTextField: UITextField!
    private var viewModel: LoginViewModelInterface = LoginViewModel(services: UserServices.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func didTapLogin() {
        // todo: toggle login button
        let username = usernameTextField.text ?? ""
        viewModel.login(username: username)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func viewModel(_ viewModel: LoginViewModelInterface, didLogin client: Client) {
        usernameTextField.text = nil
        
        guard let profileScreen = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() else { return }
        
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}
