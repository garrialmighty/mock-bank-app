//
//  TopupViewModelTests.swift
//  mock-bank-appTests
//
//  Created by Garri Nablo on 19/7/21.
//

import XCTest
@testable import mock_bank_app

class TopupViewModelTests: XCTestCase {
    
    private final class MockService: TopupInterface {
        var didTopup  = false
        var amount = -1
        
        func topup(amount: Int) {
            didTopup = true
            self.amount = amount
        }
    }
    
    private final class MockTopupView: TopupViewModelDelegate {
        var didTopup = false
        
        func viewModelDidTopup(_ viewModel: TopupViewModel) {
            didTopup = true
        }
    }
    
    private var viewModel = TopupViewModel(services: MockService())
    private var view = MockTopupView()
    private var services = MockService()
    private let mockAmount = 1337
    
    override func setUpWithError() throws {
        view = MockTopupView()
        services = MockService()
        viewModel = TopupViewModel(services: services)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
    }
    
    func testTopup() {
        viewModel.topup(amount: mockAmount)
        XCTAssertTrue(services.didTopup)
        XCTAssertEqual(services.amount, mockAmount)
        XCTAssertTrue(view.didTopup)
    }
}
