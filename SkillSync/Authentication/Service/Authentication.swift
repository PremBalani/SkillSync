//
//  Authentication.swift
//  SkillSync
//
//  Created by Prem Balani on 1/4/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase
import SwiftUI

class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    @Published var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
    var provider = OAuthProvider(providerID: "twitter.com")
    
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }
    
    @ObservedObject static var shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            hasError = false
            errorMessage = ""
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            print("DEBUG: Failed to log in user with email with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func linkWithTwitter() async throws {
        do {
            hasError = false
            errorMessage = ""
            let credential = try await provider.credential(with: nil)
            
            if let credential = credential as? OAuthCredential {
                print(credential.accessToken)
                print(credential.secret)
            }
            let result = try await Auth.auth().currentUser?.link(with: credential)
            self.userSession = result?.user
            guard let twitterProfile = result?.additionalUserInfo?.profile else { return }
            let twitterUsername = twitterProfile["screen_name"] as! String
            try await self.uploadTwitterData(twitterUsername: twitterUsername)
            
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            print("DEBUG: Failed to log in user with twitter with error \(error)")
        }
    }
    
    @MainActor
    func unlinkWithTwitter() async throws {
        do {
            hasError = false
            errorMessage = ""
            let result = try await Auth.auth().currentUser?.unlink(fromProvider: provider.providerID)
            self.userSession = result
            try await self.removeTwitterData()
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            print("DEBUG: Failed to log out user with twitter with error \(error.localizedDescription)")
        }
        
    }
    
    @MainActor
    func createUser(email: String, password: String, fullname: String, grade: String, school: String) async throws {
        do {
            hasError = false
            errorMessage = ""
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, fullname: fullname, email: email, grade: grade, school: school)
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            print("DEBUG: Failed to register user with email with error \(error.localizedDescription)")
        }
    }
    
    private func removeTwitterData() async throws{
        if self.currentUser != nil {
            self.currentUser?.twitterUsername = nil
            guard let encodedUser = try? Firestore.Encoder().encode(currentUser) else { return }
            try? await Firestore.firestore().collection("users").document(currentUser!.id).setData(encodedUser)
            try await loadUserData()
        }
    }
    
    private func uploadTwitterData(twitterUsername: String) async throws{
        if self.currentUser != nil {
            currentUser?.twitterUsername = twitterUsername
            guard let encodedUser = try? Firestore.Encoder().encode(currentUser) else { return }
            try? await Firestore.firestore().collection("users").document(currentUser!.id).setData(encodedUser)
            try await loadUserData()
        }
    }
    
    private func uploadUserData(uid: String, fullname: String, email: String, grade: String, school: String) async {
        let user = User(id: uid, fullname: fullname, school: school, email: email, grade: grade)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        self.currentUser = try await UserService.fetchUserData(withUid: currentUid)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    func completeOnboarding() {
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.hasSeenOnboarding)
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    
}
