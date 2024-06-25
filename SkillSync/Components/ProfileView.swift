//
//  ProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI
import Kingfisher
import PDFKit

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: ProfileFeedViewModel
    @Environment(\.dismiss) private var dismiss

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
                        HStack (spacing: 10) {
                            if !viewModel.transcripts.isEmpty {
                                NavigationLink {
                                    PDFKitView(viewModel: viewModel)
                                } label: {
                                    HStack {
                                        Image(systemName: "doc")
                                            .imageScale(.small)
                                        Text("School Transcript")
                                            .font(.custom("Lato-Black", size: 12))
                                    }
                                    .foregroundStyle(.babyBlue)
                                }
                            }
                            if !viewModel.transcripts.isEmpty && user.twitterUsername != nil {
                                Divider()
                            }
                            if let twitterUsername = user.twitterUsername {
                                Link(destination: URL(string: "https://twitter.com/\(twitterUsername)")!, label: {
                                    HStack {
                                        Image("x-icon")
                                            .imageScale(.small)
                                        Text("Twitter")
                                            .font(.custom("Lato-Black", size: 12))

                                    }
                                    .foregroundStyle(.babyBlue)
                                })
                            }
                        }
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
                                                .scaledToFill()
                                                .frame(width: 85, height: 85)
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
                        VStack(alignment: .leading) {
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.vertical, 30)
                }
                .padding(.top)
                .padding(.leading, 20)
                
            }
        }
        .refreshable {
            Task { try await viewModel.refreshProfileFeed(withUid: user.id) }
        }
    }
}


#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
