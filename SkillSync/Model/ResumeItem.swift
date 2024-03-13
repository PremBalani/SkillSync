//
//  ResumeItem.swift
//  SkillSync
//
//  Created by Prem Balani on 3/12/24.
//

import Foundation

struct ResumeItem: Identifiable, Hashable, Codable {
    var ownerUid: String
    var id: String
    var title: String = ""
    var subheader: String = ""
    var description: String = ""
}
