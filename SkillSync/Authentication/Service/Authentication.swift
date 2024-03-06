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
    func createUser(email: String, password: String, username: String, grade: String) async throws {
        do {
            hasError = false
            errorMessage = ""
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, username: username, email: email, grade: grade)
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
            print("DEBUG: Failed to register user with email with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(uid: String, username: String, email: String, grade: String) async {
        let user = User(id: uid, username: username, email: email, grade: grade)
        print(user)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    
}
