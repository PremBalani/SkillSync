//
//  HomeFeedView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct HomeFeedView: View {
    @StateObject var viewModel = HomeFeedViewModel()
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack (alignment: .leading){
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Discover")
                            .font(.custom("Lato-Black", size: 30))
                            .foregroundStyle(.navyBlue)
                        Text("Explore Other Projects and Get Involved")
                            .font(.custom("Lato-Regular", size: 15))
                            .foregroundStyle(.companyOrange)
                    }
                    .padding(.leading, 40)
                    .padding(.top, 80)
                    
                    
                    ForEach(viewModel.projects, id: \.self) { project in
                        HomeFeedCellView(project: project, user: project.user ?? User.MOCK_USERS[0])
                    }
                }
            }
            .scrollIndicators(.hidden)
            .refreshable {
                Task { try await viewModel.fetchProjects() }
            }
        }
        
    }
}

#Preview {
    HomeFeedView()
}
