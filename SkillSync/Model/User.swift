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
    var school: String
    let email: String
    var grade: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, fullname: "Krish Balani", profileImageUrl: nil, school: "River Hill High School", email: "kbalan3685@gmail.com", grade: "11"),
        .init(id: NSUUID().uuidString, fullname: "Prem Balani", profileImageUrl: nil, school: "River Hill High School", email: "pbalan3685@gmail.com", grade: "11")
    ]
}
