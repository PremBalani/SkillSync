//
//  ResumeItemView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/12/24.
//

import SwiftUI

struct ResumeItemView: View {
    @StateObject var viewModel: ResumeItemViewModel
    var body: some View {
        VStack (alignment: .leading){
            Text(viewModel.section)
                .font(.custom("Lato-Black", size: 14))
                .foregroundStyle(.companyOrange)
                .padding(.bottom, 5)
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.title)
                    .font(.custom("Lato-Black", size: 12))
                Text(viewModel.subheader)
                    .font(.custom("Lato-Italic", size: 12))
                Text(viewModel.description)
                    .font(.custom("Lato-Regular", size: 12))
            }
            .foregroundStyle(.mediumBlue)
        }
        .padding(.leading, 40)
    }
}

#Preview {
    ResumeItemView(viewModel: ResumeItemViewModel(section: "Clubs & Organizations", user: User.MOCK_USERS[0]))
}
