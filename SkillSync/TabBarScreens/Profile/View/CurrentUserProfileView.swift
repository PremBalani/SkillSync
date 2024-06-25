//
//  ProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI
import Kingfisher
import PDFKit

struct CurrentUserProfileView: View {
    let user: User
    @State private var showEditProfile = false
    @StateObject var viewModel: ProfileFeedViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileFeedViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            ProfileView(user: user)
                .toolbar(.hidden, for: .tabBar)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .fontWeight(.bold)
                        }
                    }
                }
        }
        .fullScreenCover(isPresented: $showEditProfile){
            EditProfileView(user: user)
        }
        .refreshable {
            Task { try await viewModel.refreshProfileFeed(withUid: user.id) }
        }
    }
}

struct ResumeSection: View {
    @State var sectionName: String
    @State var items: [ResumeItem]
    var body: some View {
        Text(sectionName)
            .font(.custom("Lato-Black", size: 14))
            .foregroundStyle(.navyBlue)
        ForEach(items) { item in
            VStack (alignment: .leading) {
                Text(item.title)
                    .font(.custom("Lato-Bold", size: 12))
                    .foregroundStyle(.companyOrange)
                Text(item.subheader)
                    .font(.custom("Lato-Regular", size: 12))
                Text(item.description)
                    .font(.custom("Lato-Regular", size: 12))
            }
            .foregroundStyle(.mediumBlue)
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let viewModel: ProfileFeedViewModel
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: URL(string: viewModel.transcripts[0].pdfURL)!)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
