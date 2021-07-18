//
//  PayViewModelTests.swift
//  mock-bank-appTests
//
//  Created by Garri Nablo on 19/7/21.
//

import XCTest
@testable import mock_bank_app

class PayViewModelTests: XCTestCase {
    
    private final class MockService: TransferInterface {
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
    
    private var viewModel = PayViewModel(services: MockService())
    private var view = MockPayView()
    private var services = MockService()
    private let mockAmount = 1337
    
    override func setUpWithError() throws {
        view = MockPayView()
        services = MockService()
        viewModel = PayViewModel(services: services)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
    }
    
    func testPay() {
        let mockedId = "mockedId"
        viewModel.pay(amount: mockAmount, id: mockedId)
        XCTAssertTrue(services.didPay)
        XCTAssertEqual(services.amount, mockAmount)
        XCTAssertEqual(services.id, mockedId)
    }
}
