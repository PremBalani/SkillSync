//
//  Project.swift
//  SkillSync
//
//  Created by Prem Balani on 1/5/24.
//

import Foundation

// Identifiable: Display them in a list, Hashable: So it can be navigatable, Codable: Upload information and Download informaion from server

struct Project: Identifiable, Hashable, Codable {
    var id: String
    var coverImageURL: String
    var title: String
    var description: String
    var ownerUid: String
    var header: String
    var user: User?
}

extension Project {
    static var MOCK_PROJECTS: [Project] = [
        .init(id: NSUUID().uuidString, coverImageURL: "https://firebasestorage.googleapis.com:443/v0/b/skillsync-c9122.appspot.com/o/profile_images%2FE2D4276B-521E-453D-86C0-4071BF966680?alt=media&token=81feb546-34bf-43b7-a7e2-9b015012763b", title: "Flappy Bird in Java", description: "Hey mates", ownerUid: NSUUID().uuidString, header: "This is my project"),
        .init(id: NSUUID().uuidString, coverImageURL: "AppImage", title: "FBLA APP", description: "Come on", ownerUid: NSUUID().uuidString, header: "This is my project")
    ]
}
