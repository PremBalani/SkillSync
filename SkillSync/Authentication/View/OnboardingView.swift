//
//  OnboardingView.swift
//  SkillSync
//
//  Created by Prem Balani on 4/26/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var scrollIndex : Int? = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 0){
                    ForEach(0...2, id: \.self) { index in
                        ZStack (alignment: .bottomLeading) {
                            Image("OnboardingBackground\(index)")
                                .resizable()
                                .ignoresSafeArea()
                                .scaledToFill()
                            VStack (alignment: .leading, spacing: 30) {
                                Text(OnboardingItem.OnboardingItems[index].slideTitle)
                                    .font(.custom("Lato-Bold", size: 32))
                                Text(OnboardingItem.OnboardingItems[index].slideDescription)
                                    .font(.custom("Lato-Regular", size: 15))
                                    .foregroundStyle(.companyOrange)
                            }
                            .frame(width:300)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 180)
                            .padding(.leading, 30)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollDisabled(true)
            .scrollPosition(id: $scrollIndex)
            .scrollTargetBehavior(.viewAligned)
            HStack {
                Button {
                    withAnimation() {
                        if scrollIndex == 0 {
                            AuthService.shared.completeOnboarding()
                        } else {
                            scrollIndex! -= 1
                        }
                    }
                    
                } label: {
                    if scrollIndex == 0 {
                        Text("Skip")
                            .font(.custom("Lato-Regular", size: 16))
                    } else {
                        Image(systemName: "chevron.left")
                            .fontWeight(.bold)
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                    }
                }
                Spacer()
                Button {
                    withAnimation() {
                        if scrollIndex == 2 {
                            AuthService.shared.completeOnboarding()
                        } else {
                            scrollIndex! += 1
                        }
                    }
                    
                } label: {
                    HStack {
                        if scrollIndex == 2 {
                            Text("Get Started")
                                .font(.custom("Lato-Regular", size: 16))
                        }
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.white)
                    .frame(width: scrollIndex == 2 ? 130 : 44, height: 44)
                    .background(.navyBlue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                }
            }
            .padding(35)
            
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    OnboardingView()
}
