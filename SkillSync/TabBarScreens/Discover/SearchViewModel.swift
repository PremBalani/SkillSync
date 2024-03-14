//
//  DiscoverViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/13/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
