//
//  HomeFeedViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import Foundation
import Firebase

class HomeFeedViewModel: ObservableObject {
    @Published var projects = [Project]()
    
    init() {
        Task { try await fetchProjects() }
    }
    
    @MainActor
    func fetchProjects() async throws {
        self.projects = try await PortfolioService.fetchFeedProjects()
    }
}
