//
//  DiscoverView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct SearchView: View {
    @State var currentUser: User
    @State private var searchText = ""
    @State var viewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            ProfileView(user: user)
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack {
                                CircularProfileImageView(user: user, size: 40)
                                VStack (alignment: .leading) {
                                    Text(user.fullname)
                                        .fontWeight(.semibold)
                                    
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .padding(.leading)
                            
                            
                        }
                    }
                }
                .padding(.top)
                .searchable(text: $searchText, prompt: "Search...")
            }
            .navigationDestination(for: User.self, destination: { user in
                CurrentUserProfileView(user: user)
            })
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .refreshable {
            Task { try await viewModel.fetchUsers() }
        }
        
    }
}

#Preview {
    SearchView(currentUser: User.MOCK_USERS[0])
}
