//
//  EditProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/6/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack() {
            HStack(){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Button {
                    Task { try await viewModel.updateUserData() }
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .padding(.bottom, 60)
            
            Text("Edit Profile")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Lato-Black", size: 24))
                .foregroundStyle(.navyBlue)
                .padding(.leading, 40)
                .padding(.bottom)
                
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack(spacing: 15) {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: 124)
                    }
                    Text("Edit Profile Picture")
                        .font(.custom("Lato-Regular", size: 12))
                        .foregroundStyle(.companyOrange)
                    
                }
            }
            .padding(.vertical)
            
            VStack(spacing: 15){
                CustomInputFieldView(title: "Name", placeholder: "Enter Your Name", text: $viewModel.newName)
                
                CustomInputFieldView(title: "Grade", placeholder: "Enter Your Grade", text: $viewModel.newGrade)
                    .keyboardType(.numberPad)
                
                CustomInputFieldView(title: "School", placeholder: "Enter Your School", text: $viewModel.newSchool)
            }
            
            Spacer()
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
