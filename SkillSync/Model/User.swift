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
    var grade: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "kbalan", fullname: "Krish", profileImageUrl: "SampleProfilePic", bio: "hello", email: "kbalan3685@gmail.com", grade: "11"),
        .init(id: NSUUID().uuidString, username: "pbalan", fullname: "Prem", profileImageUrl: "SampleProfilePic", bio: "hello", email: "pbalan3685@gmail.com", grade: "11")
    ]
}
