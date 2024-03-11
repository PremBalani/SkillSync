//
//  ProjectDetailedView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/10/24.
//

import SwiftUI
import Kingfisher

struct ProjectDetailedView: View {
    @State var user: User
    @State var project: Project
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                ZStack (alignment:.bottom) {
                    
                    KFImage(URL(string:project.coverImageURL))
                        .resizable()
                        .scaledToFit()
                    HStack {
                        Text(project.header)
                            .foregroundStyle(.white)
                            .font(.custom("Lato-Black", size: 12))
                            .lineLimit(2)
                            
                        Spacer()
                        
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            CircularProfileImageView(user: user, size: 50)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(LinearGradient(colors: [.black, .black.opacity(0.3)], startPoint: .bottom, endPoint: .top))
                    
                }
                
                Text(project.title)
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                    .padding(20)
                
                Text(project.description)
                    .font(.custom("Lato-Regular", size: 16))
                    .foregroundStyle(.babyBlue)
                    .padding(.horizontal, 20)
                
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
        }
    }
}

#Preview {
    ProjectDetailedView(user: User.MOCK_USERS[0], project: Project.MOCK_PROJECTS[0])
}
