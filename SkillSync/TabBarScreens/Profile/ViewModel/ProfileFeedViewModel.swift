//
//  ProfileFeedViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import Foundation

class ProfileFeedViewModel: ObservableObject {
    @Published var projects = [Project]()
    @Published var user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchProjects(withUid: user.id) }
    }
    
    @MainActor
    func fetchProjects(withUid uid: String) async throws {
        self.projects = try await PortfolioService.fetchUserProjects(uid: uid)
    }
}
