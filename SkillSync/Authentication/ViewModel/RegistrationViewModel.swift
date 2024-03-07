//
//  RegistrationViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 1/4/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var grade = ""
    @Published var school = ""
    @Published var hasError = false
    @Published var errorMessage = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, fullname: fullname, grade: grade, school: school)
        
        if !getSignUpError() {
            fullname = ""
            email = ""
            password = ""
            grade = ""
            school = ""
        }
    }
    
    func getSignUpError() -> Bool {
        hasError = AuthService.shared.hasError
        errorMessage = AuthService.shared.errorMessage
        return hasError
    }
}


