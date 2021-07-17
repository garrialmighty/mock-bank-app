//
//  ProfileViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    private var viewModel: ProfileViewModelInterface = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        viewModel.delegate = self
        viewModel.fetchClientProfile()
    }
    
    @IBAction private func didTapTopup() {
        // TODO: navigate to Topup screen
    }
    
    @IBAction private func didTapPay() {
        // TODO: navigate to Pay screen
    }
}

// MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate {
    func viewModel(_ viewModel: ProfileViewModelInterface, didFetchProfile client: Client) {
        usernameLabel.text = client.username
        balanceLabel.text = "\(client.balance)"
    }
}
