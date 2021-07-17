//
//  TopupViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class TopupViewController: UIViewController {

    @IBOutlet private weak var amountTextField: UITextField!
    private var viewModel: TopupViewModelInterface = TopupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction private func didTapTopup() {
        guard let amountString = amountTextField.text,
              let amount = Int(amountString) else { return }
        
        viewModel.topup(amount: amount)
    }
}

// MARK: - TopupViewModelDelegate
extension TopupViewController: TopupViewModelDelegate {
    func viewModelDidTopup(_ viewModel: TopupViewModel) {
        navigationController?.popViewController(animated: true)
    }
}
