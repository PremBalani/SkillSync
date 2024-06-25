//
//  UploadTranscriptView.swift
//  SkillSync
//
//  Created by Prem Balani on 4/8/24.
//

import SwiftUI
import Kingfisher

struct UploadTranscriptView: View {
    @StateObject var viewModel: UploadTranscriptViewModel
    @Environment(\.dismiss) var dismiss
    @State var isShowing = false
    @State var image: URL?
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: UploadTranscriptViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Upload your Transcript")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("This will be displayed on your profile")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            .padding(.leading, 40)
            
            HStack {
                Button {
                    isShowing.toggle()
                } label: {
                    ZStack {
                        if let name = viewModel.transcriptName {
                            Rectangle()
                                .fill(.navyBlue)
                            Image(systemName: "doc.text")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .foregroundStyle(.white)
                        } else {
                            Rectangle()
                                .fill(.navyBlue)
                            Image(systemName: "icloud.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .fileImporter(isPresented: $isShowing, allowedContentTypes: [.pdf]) { result in
                    do {
                        let selectedFile = try result.get()
                        if selectedFile.startAccessingSecurityScopedResource(){
                            viewModel.transcriptName = selectedFile.lastPathComponent
                            viewModel.transcriptFile = try Data(contentsOf: selectedFile)
                        }
                        selectedFile.stopAccessingSecurityScopedResource()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                .frame(width: viewModel.transcriptFile == nil ? 300 : 100, height: viewModel.transcriptFile == nil ? 300 : 100)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.mediumBlue, lineWidth: 1)
                        .frame(width: viewModel.transcriptFile == nil ? 300 : 100, height:viewModel.transcriptFile == nil ? 300 : 100)
                )
                
                
                if let fileName = viewModel.transcriptName {
                    Text(fileName)
                        .font(.custom("Lato-Regular", size: 18))
                        .foregroundStyle(.navyBlue)
                        .padding(.leading, 10)
                }
            }
            .animation(.easeIn(duration: 0.2), value: viewModel.transcriptFile)
            
            Button {
                Task{ try await viewModel.uploadTranscript() }
                dismiss()
                dismiss()
            } label: {
                Text("Upload")
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .frame(width: 320, height: 44)
                    .background(viewModel.transcriptFile == nil ? .navyBlue.opacity(0.5) : .navyBlue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            }
            .disabled(viewModel.transcriptFile == nil)
            .padding(.top, 50)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    UploadTranscriptView(user: User.MOCK_USERS[0])
}
