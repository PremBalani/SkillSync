//
//  DiscoverView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(){
        self._viewModel = StateObject(wrappedValue: SearchViewModel())
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            ProfileView(user: user)
                                
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
                .onChange(of: searchText) { oldValue, newValue in
                    if newValue == "" {
                        Task { try await viewModel.fetchUsers() }
                    } else {
                        Task { try await viewModel.search(term: newValue) }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                CurrentUserProfileView(user: user)
            })
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            Task { try await viewModel.fetchUsers() }
        }
        .refreshable {
            Task { try await viewModel.fetchUsers() }
        }
        
    }
}

#Preview {
    SearchView()
}
