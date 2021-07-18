//
//  LoginViewModelTests.swift
//  mock-bank-appTests
//
//  Created by Garri Nablo on 18/7/21.
//

import XCTest
@testable import mock_bank_app

class LoginViewModelTests: XCTestCase {
    
    private final class MockService: Authenticator {
        var didLogin = false
        
        func login(client: Client) {
            didLogin = true
        }
    }
    
    private final class MockLoginView: LoginViewModelDelegate {
        var didLogin = false
        
        func viewModel(_ viewModel: LoginViewModelInterface, didLogin client: Client) {
            didLogin = true
        }
    }
    
    private var viewModel = LoginViewModel(services: MockService())
    private var view = MockLoginView()
    private var services = MockService()

    override func setUpWithError() throws {
        view = MockLoginView()
        services = MockService()
        viewModel = LoginViewModel(services: services)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
    }
    
    func testLogin() {
        viewModel.login(username: "")
        XCTAssertTrue(view.didLogin)
        XCTAssertTrue(services.didLogin)
    }
}
