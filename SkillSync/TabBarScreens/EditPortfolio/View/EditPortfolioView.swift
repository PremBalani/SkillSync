//
//  EditPortfolioView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct EditPortfolioView: View {
    @State private var isEditingProjects = false
    @State private var isEditingAcademicAchievements = false
    @State private var isEditingCommunityService = false
    @State private var isEditingAthleticAchievements = false
    @State private var isEditingWorkExperience = false
    @State private var isEditingClubsAndOrganizations = false
    @State private var isEditingSchoolTranscript = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sync your Portfolio")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("Select the category to add content to your portfolio")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
            }
            .padding(.leading, 40)
            .padding(.top, 130)
            .padding(.bottom, 60)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 25) {
                HStack(spacing: 15) {
                    Button {
                        isEditingProjects.toggle()
                    } label: {
                        Text("Projects")
                            .portfolioButtonStyle()
                    }
                    
                    Button {
                        isEditingAcademicAchievements.toggle()
                    } label: {
                        Text("Academic Achievements")
                            .portfolioButtonStyle()
                    }
                }
                
                HStack(spacing: 15) {
                    Button {
                        isEditingCommunityService.toggle()
                    } label: {
                        Text("Community Service")
                            .portfolioButtonStyle()
                    }
                    
                    Button {
                        isEditingAthleticAchievements.toggle()
                    } label: {
                        Text("Athletic Achievements")
                            .portfolioButtonStyle()
                    }
                }
                
                HStack(spacing: 15) {
                    Button {
                        isEditingWorkExperience.toggle()
                    } label: {
                        Text("Work Experience")
                            .portfolioButtonStyle()
                    }
                    
                    Button {
                        isEditingClubsAndOrganizations.toggle()
                    } label: {
                        Text("Clubs & Organizations")
                            .portfolioButtonStyle()
                    }
                }
                
                Button {
                    isEditingSchoolTranscript.toggle()
                } label: {
                    Text("School Transcript")
                        .portfolioButtonStyle()
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $isEditingProjects) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingAthleticAchievements) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingCommunityService) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingAthleticAchievements) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingWorkExperience) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingClubsAndOrganizations) {
            Text("hi")
        }
        .fullScreenCover(isPresented: $isEditingSchoolTranscript) {
            Text("hi")
        }
    }
}

struct EditPortfolioButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(.babyBlue.opacity(0.4))
                .frame(width: 150, height: 30)
            content
                .foregroundStyle(.mediumBlue)
                .font(.custom("Lato-Black", size: 11))
        }
    }
}

extension View {
    func portfolioButtonStyle() -> some View {
        modifier(EditPortfolioButtonStyle())
    }
}

#Preview {
    EditPortfolioView()
}
