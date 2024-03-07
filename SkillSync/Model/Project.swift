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
}

extension Project {
    static var MOCK_PROJECTS: [Project] = [
        .init(id: NSUUID().uuidString, coverImageURL: "FlappyBirdProjectImage", title: "Flappy Bird in Java", description: ""),
        .init(id: NSUUID().uuidString, coverImageURL: "AppImage", title: "FBLA APP", description: "Come on")
    ]
}
