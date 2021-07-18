//
//  PayViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class PayViewController: UIViewController {
    
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var idTextField: UITextField!
    private var viewModel: PayViewModelInterface = PayViewModel(services: CoreServices.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction private func didTapPay() {
        // todo: only enable pay button when textfield has valid inputs
        guard let id = idTextField.text,
              let amountString = amountTextField.text,
              let amount = Int(amountString) else { return }
        
        viewModel.pay(amount: amount, id: id)
        amountTextField.text = nil
    }
}

// MARK: - PayViewModelDelegate
extension PayViewController: PayViewModelDelegate {
    func viewModel(_ viewModel: PayViewModel, didPay client: Client) {
        navigationController?.popViewController(animated: true)
    }
}
