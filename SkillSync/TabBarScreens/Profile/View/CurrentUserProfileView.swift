//
//  ProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI
import Kingfisher

struct CurrentUserProfileView: View {
    let user: User
    @State private var showEditProfile = false
    @StateObject var viewModel: ProfileFeedViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileFeedViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(){
                LazyVStack(alignment: .center) {
                    
                    VStack(alignment: .center, spacing:10) {
                        // Change UploadCloudImage to the Man Symbol Image
                        CircularProfileImageView(user: viewModel.user, size: 124)
                        
                        Text("\(viewModel.user.fullname)'s Portfolio")
                            .font(.custom("Lato-Black", size: 32))
                            .foregroundStyle(.navyBlue)
                        Text("\(viewModel.user.grade)th Grader at \(viewModel.user.school)  ")
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundStyle(.companyOrange)
                    }
                    .padding(.trailing, 15)
                    
                    VStack (alignment: .leading, spacing: 18) {
                        if !viewModel.projects.isEmpty {
                            Text("Projects")
                                .font(.custom("Lato-Black", size: 14))
                                .foregroundStyle(.navyBlue)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.projects) { project in
                                        NavigationLink {
                                            ProjectDetailedView(user: user, project: project)
                                                .navigationBarBackButtonHidden()
                                        } label: {
                                            KFImage(URL(string:project.coverImageURL))
                                                .resizable()
                                                .frame(width: 85, height: 85)
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(.mediumBlue, lineWidth: 2)
                                                        .frame(width: 85, height: 85)
                                                )
                                                .padding(2)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if viewModel.portfolioIsEmpty {
                            Text("There is nothing in this portfolio yet...")
                                .font(.custom("Lato-Bold", size: 15))
                                .foregroundStyle(.gray)
                        }
                        
                        
                        if !viewModel.academicAchievements.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                ResumeSection(sectionName: "Academic Achievements", items: viewModel.academicAchievements)
                            }
                        }
                        if !viewModel.athleticAchievements.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                ResumeSection(sectionName: "Athletic Achievements", items: viewModel.athleticAchievements)
                            }
                        }
                        if !viewModel.clubsAndOrganizations.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                ResumeSection(sectionName: "Clubs & Organizations", items: viewModel.clubsAndOrganizations)
                            }
                        }
                        
                        if !viewModel.communityService.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                ResumeSection(sectionName: "Community Service", items: viewModel.communityService)
                            }
                        }
                        
                        if !viewModel.workExperience.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                ResumeSection(sectionName: "Work Experience", items: viewModel.workExperience)
                            }
                        }
                        
                    }
                    .padding(.vertical, 30)
                    
                }
                .padding(.top)
                .padding(.leading)
                .toolbar(.hidden, for: .tabBar)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showEditProfile){
            EditProfileView(user: user)
        }
        .refreshable {
            Task { try await viewModel.refreshProfileFeed(withUid: user.id) }
        }
    }
}

struct ResumeSection: View {
    @State var sectionName: String
    @State var items: [ResumeItem]
    var body: some View {
        Text(sectionName)
            .font(.custom("Lato-Black", size: 14))
            .foregroundStyle(.navyBlue)
        ForEach(items) { item in
            VStack (alignment: .leading) {
                Text(item.title)
                    .font(.custom("Lato-Bold", size: 12))
                    .foregroundStyle(.companyOrange)
                Text(item.subheader)
                    .font(.custom("Lato-Regular", size: 12))
                Text(item.description)
                    .font(.custom("Lato-Regular", size: 12))
            }
            .foregroundStyle(.mediumBlue)
        }
    }
}


#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
