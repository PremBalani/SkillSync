//
//  LandingView.swift
//  SkillSync
//
//  Created by Prem Balani on 1/3/24.
//

import SwiftUI

struct LandingView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("SkillSync")
                        .font(.custom("Lato-Black", size: 40))
                        .foregroundStyle(.navyBlue)
                    Text("Your Digital Showcase")
                        .font(.custom("Lato-Bold", size: 15))
                        .foregroundStyle(.companyOrange)
                }
                .padding(.top, 180)
                
                Spacer()
                
                VStack (spacing: 20) {
                    NavigationLink {
                        LoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Log in")
                            .font(.custom("Lato-Black", size: 12))
                            .foregroundStyle(.white)
                            .frame(width: 320, height: 44)
                            .background(.navyBlue)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                    }
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sign up")
                            .font(.custom("Lato-Black", size: 12))
                            .foregroundStyle(.white)
                            .frame(width: 320, height: 44)
                            .background(.navyBlue)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                    }
                }
                .padding(.bottom, 30)
                
                Image("bottom-wave")
                    .offset(x:28, y: 15)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LandingView()
}
