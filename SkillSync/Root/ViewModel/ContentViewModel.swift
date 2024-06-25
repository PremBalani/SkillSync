//
//  ContentViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 1/4/24.
//

import Firebase
import FirebaseAuth
import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var hasCompletedOnboarding: Bool?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
        service.$hasCompletedOnboarding.sink { [weak self] hasCompletedOnboarding in
            self?.hasCompletedOnboarding = hasCompletedOnboarding
        }
        .store(in: &cancellables)
    }
}
