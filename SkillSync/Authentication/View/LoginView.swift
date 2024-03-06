//
//  LoginView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/24/23.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            
            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                Text("Welcome Back!")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("Please Enter Your Credentials")
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
            }
            
            Button {
                Task { try await viewModel.signIn() }
            } label: {
                Text("Log in")
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

        
            VStack (spacing: 6) {
                Text("Having Trouble Logging in?")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
                    
                Button {
                    print("clicked forgot password")
                } label:{
                    Text("Reset Your Password.")
                        .font(.custom("Lato-Black", size: 12))
                }
            }
            .padding(.top)
            
            Spacer()
            
            Image("bottom-wave")
                .offset(x:28, y: 15)
        }
        .ignoresSafeArea()
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
    LoginView()
}
