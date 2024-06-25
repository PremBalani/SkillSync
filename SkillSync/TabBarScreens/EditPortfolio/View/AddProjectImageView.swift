//
//  AddProjectView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/9/24.
//

import SwiftUI
import PhotosUI

struct AddProjectImageView: View {
    @State var selectedImage: PhotosPickerItem?
    @StateObject var viewModel: AddProjectViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: AddProjectViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Upload a Cover Image")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("This is how your project will appear on your profile")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.leading, 40)
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                if let image = viewModel.projectImage {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack {
                        Rectangle()
                            .fill(.navyBlue)
                        Image(systemName: "icloud.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(width: 300, height: 300)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.mediumBlue, lineWidth: 1)
                    .frame(width: 300, height: 300)
            )
            
            NavigationLink {
                AddProjectInformationView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(viewModel)
            } label: {
                Text("Next")
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .frame(width: 320, height: 44)
                    .background(viewModel.projectImage == nil ? .navyBlue.opacity(0.5) : .navyBlue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            }
            .disabled(viewModel.projectImage == nil)
            .padding(.top, 50)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    AddProjectImageView(user: User.MOCK_USERS[0])
}
