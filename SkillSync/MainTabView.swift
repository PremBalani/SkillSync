//
//  MainTabView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//
import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case feed = 0
    case discover
    case edit
    case notification
    case profile
    
    var iconName: String {
        switch self {
        case .feed:
            return "house.fill"
        case .discover:
            return "magnifyingglass"
        case .edit:
            return "Sync Logo"
        case .notification:
            return "message.badge.fill"
        case .profile:
            return "person.fill"
        }
    }
}

struct MainTabView: View {
    let user: User
    @State var selectedTab = 0
    var body: some View {
        ZStack (alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeFeedView()
                    .tag(0)
                DiscoverView()
                    .tag(1)
                EditPortfolioView()
                    .tag(2)
                NotificationView()
                    .tag(3)
                ProfileView(user: user)
                    .tag(4)
            }
            
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.navyBlue.opacity(0.7))
            .cornerRadius(35)
            .padding(.horizontal, 26)
            
        }
    }
}

extension MainTabView {
    func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        HStack (spacing: 10) {
            Spacer()
            if(imageName == "Sync Logo") {
                Image(imageName)
                    .resizable()
                    .foregroundStyle(isActive ? .white : .black)
                    .frame(width:25, height: 35)
                    .offset(x:9)
                Spacer()
            } else {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundStyle(isActive ? .white : .black)
                    .frame(width:20, height: 20)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .navyBlue : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
