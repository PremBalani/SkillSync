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
                        .navigationBarBackButtonHidden()
                } label: {
                    ZStack(alignment: .bottomLeading) {
                        KFImage(URL(string: project.coverImageURL))
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text(project.title)
                                .font(.custom("Lato-Black", size: 24))
                                .lineLimit(2)
                            Text(project.header)
                                .font(.custom("Lato-Regular", size: 12))
                                .lineLimit(2, reservesSpace: true)
                        }
                        .foregroundStyle(.white)
                        .padding(.leading, 20)
                        .padding(.vertical, 30)
                        .background(LinearGradient(colors: [.black, .black.opacity(0.3)], startPoint: .bottom, endPoint: .top).frame(width: 1000))
                        .multilineTextAlignment(.leading)
                    }
                }
                
                NavigationLink {
                    ProfileView(user: user)
                        .navigationBarBackButtonHidden()
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
