//
//  ProfileViewModelTests.swift
//  mock-bank-appTests
//
//  Created by Garri Nablo on 18/7/21.
//

import XCTest
@testable import mock_bank_app

class ProfileViewModelTests: XCTestCase {
    
    private final class MockService: ProfileFetcher {
        var didFetchProfile = false
        
        func getProfile() -> Client {
            didFetchProfile = true
            return Client()
        }
    }
    
    private final class MockProfileView: ProfileViewModelDelegate {
        var didFetchProfile = false
        
        func viewModel(_ viewModel: ProfileViewModelInterface, didFetchProfile client: Client) {
            didFetchProfile = true
        }
    }
    
    private var viewModel = ProfileViewModel(services: MockService())
    private var view = MockProfileView()
    private var services = MockService()

    override func setUpWithError() throws {
        view = MockProfileView()
        services = MockService()
        viewModel = ProfileViewModel(services: services)
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
    }
    
    func testFetchClientProfile() {
        viewModel.fetchClientProfile()
        XCTAssertTrue(services.didFetchProfile)
        XCTAssertTrue(view.didFetchProfile)
    }
}
