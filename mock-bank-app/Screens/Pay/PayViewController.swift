//
//  PayViewController.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import UIKit

class PayViewController: UIViewController {
    
    @IBOutlet private weak var recipientLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!
    private var viewModel: PayViewModelInterface = PayViewModel(recipientServices: UserServices.shared,
                                                                transferServices: CoreServices.shared)
    
    // todo: allow inputting username
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchClients()
    }
    
    @IBAction private func didTapPay() {
        guard let amountString = amountTextField.text,
              let amount = Int(amountString) else { return }
        
        viewModel.pay(amount: amount)
        amountTextField.text = nil
    }
}

// MARK: - PayViewModelDelegate
extension PayViewController: PayViewModelDelegate {
    func viewModel(_ viewModel: PayViewModel, didFetch recipients: [String]) {
        
        // Clarify with BA, PO, and designer on how to display list of available pay recipients.
        guard let recipient = recipients.first else { return }
        
        recipientLabel.text =  recipient
        
        // For now we just fetch the first available recipient.
        self.viewModel.selectClientRecipient(recipient)
    }
    
    func viewModel(_ viewModel: PayViewModel, didPay client: Client) {
        navigationController?.popViewController(animated: true)
    }
}
