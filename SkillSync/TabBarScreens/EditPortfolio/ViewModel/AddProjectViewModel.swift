//
//  AddProjectViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/9/24.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class AddProjectViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var projectImage: Image?
    @Published var headerText: String = ""
    @Published var headerPlaceholder: String
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var onPublicFeed: String = "Public Feed"
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        headerPlaceholder = "Read about \(user.fullname)'s (Click here to type)"
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.projectImage = Image(uiImage: uiImage)
    }
    
    func uploadProject() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = Firestore.firestore().collection("projects").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let project = Project(id: postRef.documentID, coverImageURL: imageUrl, title: title, description: description, ownerUid: uid, header: headerText)
        guard let encodedProject = try? Firestore.Encoder().encode(project) else { return }
        
        try await postRef.setData(encodedProject)
    }
}

