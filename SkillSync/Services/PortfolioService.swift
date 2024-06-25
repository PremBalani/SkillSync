//
//  PortfolioService.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import Foundation
import Firebase

class PortfolioService {
    static func fetchFeedProjects() async throws -> [Project] {
        let snapshot = try await Firestore.firestore().collection("projects").getDocuments()
        var projects = try snapshot.documents.compactMap({ document in
            let project = try document.data(as: Project.self)
            return project
        })
        
        for i in 0 ..< projects.count {
            let ownerUid = projects[i].ownerUid
            let projectUser = try await UserService.fetchUserData(withUid: ownerUid)
            projects[i].user = projectUser
        }
        
        return projects
    }
    
    static func fetchUserProjects(uid: String) async throws -> [Project] {
        let snapshot = try await Firestore.firestore().collection("projects").getDocuments()
        var projects = try snapshot.documents.compactMap({ document in
            let project = try document.data(as: Project.self)
            if project.ownerUid == uid {
                return project
            } else {
                return nil
            }
        })
        
        for i in 0 ..< projects.count {
            let ownerUid = projects[i].ownerUid
            let projectUser = try await UserService.fetchUserData(withUid: ownerUid)
            projects[i].user = projectUser
        }
        
        return projects
    }
    
    static func fetchUserResumeItems(uid: String, item: String) async throws -> [ResumeItem] {
        let snapshot = try await Firestore.firestore().collection(item).whereField("ownerUid", isEqualTo: uid).getDocuments()
        var items = try snapshot.documents.compactMap { document in
            return try document.data(as: ResumeItem.self)
        }
        return items
    }
    
    static func fetchUserTranscript(uid: String) async throws -> [Transcript] {
        let snapshot = try await Firestore.firestore().collection("transcripts").whereField("ownerUid", isEqualTo: uid).getDocuments()
        var item = try snapshot.documents.compactMap { document in
            return try document.data(as: Transcript.self)
        }
        return item
    }
}
