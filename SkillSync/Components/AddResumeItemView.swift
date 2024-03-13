//
//  AddAcademicAchievementView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/12/24.
//

import SwiftUI

struct AddResumeItemView: View {
    @State var title: String
    @State var subheader: String
    @State var bodyText: String
    @StateObject var viewModel: ResumeItemViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User, section: String, title: String, subheader: String, bodyText: String) {
        self._viewModel = StateObject(wrappedValue: ResumeItemViewModel(section: section, user: user))
        self._title = State<String>(initialValue: title)
        self._subheader = State<String>(initialValue: subheader)
        self._bodyText = State<String>(initialValue: bodyText)
    }
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 40) {
            ResumeItemView(viewModel: viewModel)
            
            VStack (spacing: 15) {
                CustomInputFieldView(title: title, placeholder: "", text: $viewModel.title)
                CustomInputFieldView(title: subheader, placeholder: "", text: $viewModel.subheader)
                CustomInputFieldView(title: bodyText, placeholder: "", text: $viewModel.description)
            }
        }
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
                    Task{ try await viewModel.uploadResumeItem() }
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
    AddResumeItemView(user: User.MOCK_USERS[0], section: "Clubs & Organizations", title: "Title", subheader: "Position", bodyText: "body")
}
