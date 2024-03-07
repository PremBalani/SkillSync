//
//  EditProfileViewModel.swift
//  SkillSync
//
//  Created by Prem Balani on 3/6/24.
//

import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var newName = ""
    @Published var newGrade = ""
    @Published var newSchool = ""
    
    @Published var profileImage: Image?
    
    init(user: User) {
        self.user = user
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        
        var data = [String:Any]()
        
        if user.fullname != newName && !newName.isEmpty {
            data["fullname"] = newName
        }
        
        if user.grade != newGrade && !newGrade.isEmpty {
            data["grade"] = newGrade
        }
        
        if user.school != newSchool && !newSchool.isEmpty {
            data["school"] = newSchool
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
