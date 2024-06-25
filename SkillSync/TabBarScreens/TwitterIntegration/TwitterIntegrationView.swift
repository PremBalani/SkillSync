//
//  TwitterIntegrationView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/14/24.
//

import SwiftUI
import WebKit

struct TwitterIntegrationView: View {
    let user: User
    @StateObject var viewModel: TwitterIntegrationViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: TwitterIntegrationViewModel(user: user))
        self.user = user
    }
    var body: some View {
        VStack {
            TwitterWebView()
            if let twitterUsername = AuthService.shared.currentUser!.twitterUsername {
                Text("You're connected.")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Link(destination: URL(string: "https://twitter.com/\(twitterUsername)")!, label: {
                    Text("Link to profile")
                        .font(.custom("Lato-Black", size: 12))
                        .foregroundStyle(.babyBlue)
                })
                Button {
                    Task { 
                        try await viewModel.signOut()
                        try await viewModel.refreshUser(uid: user.id)
                    }
                    
                } label: {
                    HStack(spacing: 80) {
                        Image("x-icon")
                        Text("Logout with X")
                        Spacer()
                    }
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(width: 320, height: 44)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                }
                .alert("Error", isPresented: $viewModel.hasError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.errorMessage)
                }
                
            } else {
                Button {
                    Task {
                        try await viewModel.signIn()
                        try await viewModel.refreshUser(uid: user.id)
                    }
                    
                } label: {
                    HStack(spacing: 80) {
                        Image("x-icon")
                        Text("Continue with X")
                        Spacer()
                    }
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(width: 320, height: 44)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                }
                .alert("Error", isPresented: $viewModel.hasError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.errorMessage)
                }
                
                Button {
                    Task {
                        try await viewModel.signOut()
                        try await AuthService.shared.loadUserData()
                    }
                                    } label: {
                    HStack(spacing: 80) {
                        Image("x-icon")
                        Text("Logout with X")
                        Spacer()
                    }
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(width: 320, height: 44)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
                }
                .alert("Error", isPresented: $viewModel.hasError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(viewModel.errorMessage)
                }
            }
        }
    }
}

#Preview {
    TwitterIntegrationView(user:User.MOCK_USERS[0])
}
