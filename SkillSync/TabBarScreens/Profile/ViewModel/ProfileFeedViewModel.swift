//
//  ProfileFeedViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import Foundation

class ProfileFeedViewModel: ObservableObject {
    @Published var academicAchievements = [ResumeItem]()
    @Published var communityService = [ResumeItem]()
    @Published var athleticAchievements = [ResumeItem]()
    @Published var workExperience = [ResumeItem]()
    @Published var clubsAndOrganizations = [ResumeItem]()
    @Published var projects = [Project]()
    @Published var user: User
    private var items = ["Academic Achievements", "Community Service", "Athletic Achievements", "Work Experience", "Clubs & Organizations"]
    
    init(user: User) {
        self.user = user
        Task { try await fetchProjects(withUid: user.id) }
        Task { try await fetchResumeItems(withUid: user.id) }
    }
    
    @MainActor
    func fetchProjects(withUid uid: String) async throws {
        self.projects = try await PortfolioService.fetchUserProjects(uid: uid)
    }
    
    @MainActor
    func fetchResumeItems(withUid uid: String) async throws {
        self.academicAchievements = try await PortfolioService.fetchUserResumeItems(uid: uid, item: items[0])
        self.communityService = try await PortfolioService.fetchUserResumeItems(uid: uid, item: items[1])
        self.athleticAchievements = try await PortfolioService.fetchUserResumeItems(uid: uid, item: items[2])
        self.workExperience = try await PortfolioService.fetchUserResumeItems(uid: uid, item: items[3])
        self.clubsAndOrganizations = try await PortfolioService.fetchUserResumeItems(uid: uid, item: items[4])
    }
    
    @MainActor
    func refreshProfileFeed(withUid uid: String) async throws {
        try await fetchProjects(withUid: uid)
        try await fetchResumeItems(withUid: uid)
    }
}
