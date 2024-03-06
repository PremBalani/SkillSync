//
//  User.swift
//  SkillSync
//
//  Created by Prem Balani on 12/29/23.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    var fullname: String
    var profileImageUrl: String?
    var bio: String?
    let email: String
    var grade: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, fullname: "Krish Balani", profileImageUrl: "HeadshotImage", bio: "hello", email: "kbalan3685@gmail.com", grade: "11"),
        .init(id: NSUUID().uuidString, fullname: "Prem Balani", profileImageUrl: "SampleProfilePic", bio: "hello", email: "pbalan3685@gmail.com", grade: "11")
    ]
}
