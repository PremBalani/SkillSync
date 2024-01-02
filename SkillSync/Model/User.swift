//
//  User.swift
//  SkillSync
//
//  Created by Prem Balani on 12/29/23.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var fullname: String?
    var profileImageUrl: String?
    var bio: String?
    let email: String
    
    
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "kbakan", fullname: "Krish", profileImageUrl: "SampleProfilePic", bio: "hello", email: "kbakan3685@gmail.com"),
        .init(id: NSUUID().uuidString, username: "pbakan", fullname: "Prem", profileImageUrl: "SampleProfilePic", bio: "hello", email: "pbakan3685@gmail.com"),
        .init(id: NSUUID().uuidString, username: "rbakan", fullname: "Rishi", profileImageUrl: "SampleProfilePic", bio: "hello", email: "rbakan3685@gmail.com"),
        .init(id: NSUUID().uuidString, username: "BaapaIndianElite", fullname: "Baapa", profileImageUrl: "SampleProfilePic", bio: "hello", email: "kbakan3685@gmail.com")
    ]
}
