//
//  OnboardingItems.swift
//  SkillSync
//
//  Created by Prem Balani on 4/29/24.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id: String
    let slideTitle: String
    let slideDescription: String
}

extension OnboardingItem {
    static var OnboardingItems: [OnboardingItem] = [
        .init(id: NSUUID().uuidString, slideTitle: "Personalize your portfolio", slideDescription: "Add customization widgets to showcase your projects and achievements "),
        .init(id: NSUUID().uuidString, slideTitle: "Gain inspiration from other projects", slideDescription: "Read about other student’s projects on your discover feed"),
        .init(id: NSUUID().uuidString, slideTitle: "Share and interact with other portfolios", slideDescription: "Interact with other users to grow your professional network")
    ]
}
