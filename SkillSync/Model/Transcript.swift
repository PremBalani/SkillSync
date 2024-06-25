//
//  Transcript.swift
//  SkillSync
//
//  Created by Prem Balani on 4/11/24.
//

import Foundation

struct Transcript: Identifiable, Hashable, Codable {
    var id: String
    var pdfURL: String
    var ownerUid: String
    var user: User?
}
