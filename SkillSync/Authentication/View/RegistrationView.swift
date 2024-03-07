//
//  RegistrationView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/26/23.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack() {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Sign Up")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("Please Create Your Credentials")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
            }
            .padding(.leading, 40)
            .padding(.vertical, 60)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
            VStack (spacing: 20) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundStyle(.mediumBlue)
                        .imageScale(.large)
                        .fontWeight(.bold)
                    
                    TextField("",
                              text: $viewModel.email,
                              prompt: Text("Email")
                        .foregroundStyle(.mediumBlue)
                        .font(.custom("Lato-Black", size: 12))
                    )
                    .foregroundStyle(.mediumBlue)
                    .font(.custom("Lato-Black", size: 12))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                }
                .padding(12)
                .background(.babyBlue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 37)
                
                HStack {
                    Image(systemName: "person")
                        .foregroundStyle(.mediumBlue)
                        .imageScale(.large)
                        .fontWeight(.bold)
                    
                    TextField("",
                              text: $viewModel.fullname,
                              prompt: Text("Full Name")
                        .foregroundStyle(.mediumBlue)
                        .font(.custom("Lato-Black", size: 12))
                    )
                    .foregroundStyle(.mediumBlue)
                    .font(.custom("Lato-Black", size: 12))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                }
                .padding(12)
                .background(.babyBlue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 37)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundStyle(.mediumBlue)
                        .imageScale(.large)
                        .fontWeight(.bold)
                    
                    SecureField("",
                                text: $viewModel.password,
                                prompt: Text("Password")
                        .foregroundStyle(.mediumBlue)
                        .font(.custom("Lato-Black", size: 12))
                    )
                    .foregroundStyle(.mediumBlue)
                }
                .padding(12)
                .background(.babyBlue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 37)
                
                HStack {
                    Image(systemName: "building")
                        .foregroundStyle(.mediumBlue)
                        .imageScale(.large)
                        .fontWeight(.bold)
                    
                    TextField("",
                              text: $viewModel.school,
                              prompt: Text("School")
                        .foregroundStyle(.mediumBlue)
                        .font(.custom("Lato-Black", size: 12))
                    )
                    .foregroundStyle(.mediumBlue)
                    .font(.custom("Lato-Black", size: 12))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }
                .padding(12)
                .background(.babyBlue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 37)
                
                HStack {
                    Image(systemName: "book")
                        .foregroundStyle(.mediumBlue)
                        .imageScale(.large)
                        .fontWeight(.bold)
                    
                    TextField("",
                              text: $viewModel.grade,
                              prompt: Text("Grade Level (9-12)")
                        .foregroundStyle(.mediumBlue)
                        .font(.custom("Lato-Black", size: 12))
                    )
                    .keyboardType(.numberPad)
                    .foregroundStyle(.mediumBlue)
                    .font(.custom("Lato-Black", size: 12))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    
                }
                .padding(12)
                .background(.babyBlue.opacity(0.4))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 37)
                
            }
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign up")
                    .font(.custom("Lato-Black", size: 12))
                    .foregroundStyle(.white)
                    .frame(width: 320, height: 44)
                    .background(.navyBlue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            }
            .padding(.vertical, 40)
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        
            
            Spacer()
            
            Image("bottom-wave")
                .offset(x:28, y: 15)
        }
        .ignoresSafeArea(.all)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        
    }
}

#Preview {
    RegistrationView()
}
