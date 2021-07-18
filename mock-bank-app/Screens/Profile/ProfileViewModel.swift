//
//  ProfileViewModel.swift
//  mock-bank-app
//
//  Created by Garri Nablo on 17/7/21.
//

import Foundation

protocol ProfileViewModelInterface {
    var delegate: ProfileViewModelDelegate? { get set }
    func fetchClientProfile()
}

protocol ProfileViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: ProfileViewModelInterface, didFetchProfile client: Client)
}

struct ProfileViewModel: ProfileViewModelInterface {
    
    weak var delegate: ProfileViewModelDelegate?
    private let services: ProfileFetcher
    
    init(services: ProfileFetcher) {
        self.services = services
    }
    
    func fetchClientProfile() {
        let profile = services.getProfile()
        delegate?.viewModel(self, didFetchProfile: profile)
    }
}
