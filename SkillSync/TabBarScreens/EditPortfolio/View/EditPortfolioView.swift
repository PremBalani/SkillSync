//
//  EditPortfolioView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct EditPortfolioView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack() {
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
                        NavigationLink {
                            AddProjectImageView(user: user)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("Projects")
                                .portfolioButtonStyle()
                        }
                        NavigationLink {
                            Text("hi")
                        } label: {
                            Text("Academic Achievements")
                                .portfolioButtonStyle()
                        }
                    }
                    
                    HStack(spacing: 15) {
                        NavigationLink {
                            Text("hi")
                        } label: {
                            Text("Community Service")
                                .portfolioButtonStyle()
                        }
                        
                        NavigationLink {
                            Text("hi")
                        } label: {
                            Text("Athletic Achievements")
                                .portfolioButtonStyle()
                        }
                    }
                    
                    HStack(spacing: 15) {
                        NavigationLink {
                            Text("hi")
                        } label: {
                            Text("Work Experience")
                                .portfolioButtonStyle()
                        }
                        
                        NavigationLink {
                            Text("hi")
                        } label: {
                            Text("Clubs & Organizations")
                                .portfolioButtonStyle()
                        }
                    }
                    
                    NavigationLink {
                        Text("hi")
                    } label: {
                        Text("School Transcript")
                            .portfolioButtonStyle()
                    }
                }
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Finish")
                        .foregroundStyle(.white)
                        .font(.custom("Lato-Black", size: 12))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.navyBlue)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 40)
                }
            }
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
    EditPortfolioView(user: User.MOCK_USERS[0])
}
