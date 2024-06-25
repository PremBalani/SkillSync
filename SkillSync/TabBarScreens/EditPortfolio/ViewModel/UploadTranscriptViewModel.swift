//
//  UploadTranscriptViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 4/8/24.
//

import Foundation
import SwiftUI
import Firebase

class UploadTranscriptViewModel: ObservableObject {
    @Published var transcriptFile: Data?
    @Published var transcriptName: String?
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    
    func uploadTranscript() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let postRef = Firestore.firestore().collection("transcripts").document()
        guard let data = transcriptFile else { return }
        guard let pdfUrl = try await ImageUploader.uploadPDF(data: data) else { return }
        let transcript = Transcript(id: postRef.documentID, pdfURL: pdfUrl, ownerUid: uid)
        guard let encodedTranscript = try? Firestore.Encoder().encode(transcript) else { return }
        
        try await postRef.setData(encodedTranscript)
    }
}
