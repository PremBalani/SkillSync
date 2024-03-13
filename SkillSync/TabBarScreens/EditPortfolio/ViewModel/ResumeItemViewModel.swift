//
//  ResumeItemViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/12/24.
//

import Foundation
import SwiftUI
import Firebase

class ResumeItemViewModel: ObservableObject {
    @Published var user: User
    @Published var section: String
    @Published var title: String = ""
    @Published var subheader: String = ""
    @Published var description: String = ""
    
    init(section: String, user: User) {
        self.section = section
        self.user = user
    }
    
    func uploadResumeItem() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let postRef = Firestore.firestore().collection(section).document()
        let resumeItem = ResumeItem(ownerUid: uid, id: postRef.documentID, title: title, subheader: subheader, description: description)
        guard let encodedResumeItem = try? Firestore.Encoder().encode(resumeItem) else { return }
        
        try await postRef.setData(encodedResumeItem)
        
    }
}
