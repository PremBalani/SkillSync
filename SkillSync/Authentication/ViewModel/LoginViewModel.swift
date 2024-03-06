//
//  LoginViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 1/5/24.
//

import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var errorMessage = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
        
        if !getSignInError() {
            email = ""
            password = ""
        }
    }
    
    func getSignInError() -> Bool {
        hasError = AuthService.shared.hasError
        errorMessage = AuthService.shared.errorMessage
        return hasError
    }
}
