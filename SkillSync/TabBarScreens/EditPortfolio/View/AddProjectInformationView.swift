//
//  AddProjectInformationView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/9/24.
//

import SwiftUI

struct AddProjectInformationView: View {
    @EnvironmentObject var viewModel: AddProjectViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                ZStack (alignment:.bottom) {
                    if let image = viewModel.projectImage {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(Project.MOCK_PROJECTS[0].coverImageURL)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    TextField("",
                              text: $viewModel.headerText,
                              prompt: Text(viewModel.headerPlaceholder)
                        .foregroundStyle(.white)
                        .font(.custom("Lato-Black", size: 12)),
                              axis: .vertical
                    )
                    .foregroundStyle(.white)
                    .font(.custom("Lato-Black", size: 12))
                    .lineLimit(2)
                    .background(
                        Rectangle().stroke(lineWidth: 2.0)
                            .foregroundStyle(.babyBlue)
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(LinearGradient(colors: [.black, .black.opacity(0.3)], startPoint: .bottom, endPoint: .top))
                    .multilineTextAlignment(.leading)
                }
                
                TextField("",
                          text: $viewModel.title,
                          prompt: Text("Enter a Title")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                )
                .font(.custom("Lato-Black", size: 24))
                .foregroundStyle(.navyBlue)
                .background(
                    Rectangle().stroke(lineWidth: 3.0)
                        .foregroundStyle(.babyBlue)
                )
                .padding(20)
                
                TextField("",
                          text: $viewModel.description,
                          prompt: Text("Enter Your Description")
                    .font(.custom("Lato-Regular", size: 16))
                    .foregroundStyle(.babyBlue), axis: .vertical
                )
                .font(.custom("Lato-Regular", size: 16))
                .foregroundStyle(.babyBlue)
                .background(
                    Rectangle().stroke(lineWidth: 3.0)
                        .foregroundStyle(.babyBlue)
                )
                .padding(.horizontal, 20)
                .lineLimit(30, reservesSpace: true)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.black)
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button {
                    Task{ try await viewModel.uploadProject() }
                    dismiss()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    AddProjectInformationView()
        .environmentObject(AddProjectViewModel(user: User.MOCK_USERS[0]))
}
