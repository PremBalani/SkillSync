//
//  RegistrationViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 1/4/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var grade = ""
    @Published var hasError = false
    @Published var errorMessage = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username, grade: grade)
        
        if !getSignUpError() {
            username = ""
            email = ""
            password = ""
            grade = ""
        }
    }
    
    func getSignUpError() -> Bool {
        hasError = AuthService.shared.hasError
        errorMessage = AuthService.shared.errorMessage
        return hasError
    }
}


