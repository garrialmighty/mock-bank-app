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
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchClientProfile()
    }
    
    @IBAction private func didTapTopup() {
        guard let topupScreen = UIStoryboard(name: "Topup", bundle: nil).instantiateInitialViewController() else { return }
        
        navigationController?.pushViewController(topupScreen, animated: true)
    }
    
    @IBAction private func didTapPay() {
        guard let topupScreen = UIStoryboard(name: "Pay", bundle: nil).instantiateInitialViewController() else { return }
        
        navigationController?.pushViewController(topupScreen, animated: true)
    }
}

// MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate {
    func viewModel(_ viewModel: ProfileViewModelInterface, didFetchProfile client: Client) {
        usernameLabel.text = client.username
        balanceLabel.text = "\(client.balance)"
    }
}
