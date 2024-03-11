//
//  HomeFeedCellView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/9/24.
//

import SwiftUI
import Kingfisher

struct HomeFeedCellView: View {
    @State var project: Project
    @State var user: User
    var body: some View {
            ZStack (alignment: .topLeading) {
                NavigationLink {
                    ProjectDetailedView(user: user, project: project)
                } label: {
                    ZStack(alignment: .bottom) {
                        KFImage(URL(string: project.coverImageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 300)
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text(project.title)
                                .font(.custom("Lato-Black", size: 24))
                                .lineLimit(2)
                            Text(project.header)
                                .font(.custom("Lato-Regular", size: 12))
                                .lineLimit(2, reservesSpace: true)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 30)
                        .background(LinearGradient(colors: [.black, .black.opacity(0.3)], startPoint: .bottom, endPoint: .top))
                        .multilineTextAlignment(.leading)
                    }
                }
                
                NavigationLink {
                    ProfileView(user: user)
                } label: {
                    CircularProfileImageView(user: user, size: 50)
                        .padding()
                }
            }
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)))
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
        
    }
    
}

#Preview {
    HomeFeedCellView(project: Project.MOCK_PROJECTS[0], user: User.MOCK_USERS[0])
}
