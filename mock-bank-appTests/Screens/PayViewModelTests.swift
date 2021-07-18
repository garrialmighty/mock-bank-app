//
//  PayViewModelTests.swift
//  mock-bank-appTests
//
//  Created by Garri Nablo on 19/7/21.
//

import XCTest
@testable import mock_bank_app

class PayViewModelTests: XCTestCase {

    private final class MockRecipientService: RecipientFetcher {
        var didFetch  = false
        
        func fetchRecipientClients() -> [Client] {
            didFetch = true
            return []
        }
    }
    
    private final class MockTransferService: TransferInterface {
        var didPay = false
        var amount = -1
        var id = ""
        
        func pay(amount: Int, to id: String) {
            didPay = true
            self.amount = amount
            self.id = id
        }
    }
    
    private final class MockPayView: PayViewModelDelegate {
        var didFetch = false
        var didPay = false
        
        func viewModel(_ viewModel: PayViewModel, didFetch recipients: [String]) {
            didFetch = true
        }
        
        func viewModel(_ viewModel: PayViewModel, didPay client: Client) {
            didPay = true
        }
    }
    
    private var viewModel = PayViewModel(recipientServices: MockRecipientService(),
                                         transferServices: MockTransferService())
    private var view = MockPayView()
    private var recipientServices = MockRecipientService()
    private var transferServices = MockTransferService()
    private let mockAmount = 1337
    
    override func setUpWithError() throws {
        view = MockPayView()
        recipientServices = MockRecipientService()
        transferServices = MockTransferService()
        viewModel = PayViewModel(recipientServices: recipientServices,
                                 transferServices: transferServices)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
    }
    
    func testFetchClients() {
        viewModel.fetchClients()
        XCTAssertTrue(recipientServices.didFetch)
        XCTAssertTrue(view.didFetch)
    }
    
    func testPay() {
        viewModel.pay(amount: mockAmount)
        XCTAssertTrue(transferServices.didPay)
        XCTAssertEqual(transferServices.amount, mockAmount)
    }
    
    func testSelectingClientRecipient() {
        let mockedId = "mockedId"
        viewModel.pay(amount: mockAmount)
        XCTAssertNotEqual(transferServices.id, mockedId)
        
        viewModel.selectClientRecipient(mockedId)
        viewModel.pay(amount: mockAmount)
        XCTAssertEqual(transferServices.id, mockedId)
    }
}
