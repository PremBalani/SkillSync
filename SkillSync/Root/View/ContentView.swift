//
//  ContentView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LandingView()
            } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser) 
            } else {
                MainTabView(user: User.MOCK_USERS[0])
            }
                
        }
    }
}

#Preview {
    ContentView()
}
