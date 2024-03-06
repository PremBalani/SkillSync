//
//  ProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    var body: some View {
        NavigationStack {
            ScrollView(){
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(user.username)'s Portfolio")
                                .font(.custom("Lato-Black", size: 32))
                                .foregroundStyle(.navyBlue)
                            Text("Grade Level:  \(user.grade)")
                                .font(.custom("Lato-Bold", size: 16))
                                .foregroundStyle(.companyOrange)
                        }
                        
                        Spacer()
                        
                        Image("HeadshotImage")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.mediumBlue, lineWidth: 1.0)
                            }
                    }
                    .padding(.trailing, 15)
                    VStack (alignment: .leading, spacing: 20) {
                        Text("Projects")
                            .font(.custom("Lato-Black", size: 14))
                            .foregroundStyle(.navyBlue)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Project.MOCK_PROJECTS) { project in
                                    Image(project.coverImageURL)
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.mediumBlue, lineWidth: 1)
                                                .frame(width: 85, height: 85)
                                        )
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Academic Achievements")
                                .font(.custom("Lato-Black", size: 14))
                                .foregroundStyle(.navyBlue)
                            
                            VStack (alignment: .leading) {
                                Text("December 2022: FBLA Regional Leadership Conference")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("1st Place - Parliamentary Procedures")
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            .foregroundStyle(.mediumBlue)
                            
                            VStack (alignment: .leading) {
                                Text("March 2022: FBLA State Leadership Conference")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("2nd Place - Intro to Information Technology")
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            .foregroundStyle(.mediumBlue)
                            
                            VStack (alignment: .leading) {
                                Text("December 2021: FBLA Regional Leadership Conference")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("1st Place - Intro to Information Technology")
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            .foregroundStyle(.mediumBlue)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Clubs & Organizations")
                                .font(.custom("Lato-Black", size: 14))
                                .foregroundStyle(.navyBlue)
                            
                            VStack (alignment: .leading) {
                                Text("October 2023 - Present: Maryland Tourneys")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("Social Media Coodinator")
                                    .font(.custom("Lato-Regular", size: 12))
                                Text(" - Developed and executed engaging social media posts to raise awareness for charity events")
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            .foregroundStyle(.mediumBlue)
                            
                            VStack (alignment: .leading) {
                                Text("August 2021 - Present: River Hill FBLA")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("Vice President of Competitive Events")
                                    .font(.custom("Lato-Regular", size: 12))
                                Text(" - Collaborated with a team of 23 officers to administer competitive events, oversee chapter operations, and develop relationships with local business leaders to serve a chapter of over 300 active members")
                                    .font(.custom("Lato-Regular", size: 12))
                                    
                            }
                            .padding(.trailing, 15)
                            .foregroundStyle(.mediumBlue)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Community Service")
                                .font(.custom("Lato-Black", size: 14))
                                .foregroundStyle(.navyBlue)
                            
                            VStack (alignment: .leading) {
                                Text("September 2023 - Present: Howard County Teen Court")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("Student Juror")
                                    .font(.custom("Lato-Regular", size: 12))
                                Text(" - Served 4+ hours on teen court juries with a focus of rehabilitating first-time juvenile offenders by providing consequences to teach them to be accountable for their actions and to encourage giving back to the community")
                                    .font(.custom("Lato-Regular", size: 12))
                            }
                            .foregroundStyle(.mediumBlue)
                            
                            VStack (alignment: .leading) {
                                Text("May 2020 - August 2020: Clarksville Youth Care Group")
                                    .font(.custom("Lato-Bold", size: 12))
                                    .foregroundStyle(.companyOrange)
                                Text("Volunteer")
                                    .font(.custom("Lato-Regular", size: 12))
                                Text(" - Constructed 400 reusable heavy-duty face shields to distribute to 101 different essential organizations")
                                    .font(.custom("Lato-Regular", size: 12))
                                    
                            }
                        }
                        .padding(.trailing, 15)
                        .foregroundStyle(.mediumBlue)
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
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
