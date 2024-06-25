//
//  LinkWithTwitterViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/14/24.
//

import SwiftUI
import Foundation

class TwitterIntegrationViewModel: ObservableObject {
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func signIn() async throws {
        try await AuthService.shared.linkWithTwitter()
    }
    
    func signOut() async throws {
        try await AuthService.shared.unlinkWithTwitter()
    }
    
    func getSignInError() -> Bool {
        hasError = AuthService.shared.hasError
        errorMessage = AuthService.shared.errorMessage
        return hasError
    }
    
    func refreshUser(uid: String) async throws {
        self.user = try await UserService.fetchUserData(withUid: uid)
    }
    
}
