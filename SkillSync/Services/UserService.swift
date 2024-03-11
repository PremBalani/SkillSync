//
//  UserService.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import Foundation
import Firebase

class UserService {
    static func fetchUserData(withUid uid: String) async throws -> User{
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUsers() async throws -> [User]{
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return try snapshot.documents.compactMap { document in
            return try document.data(as: User.self)
        }
    }
}
