//
//  CircularProfileImageView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/8/24.
//
import Kingfisher
import SwiftUI

struct CircularProfileImageView: View {
    let user: User
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .frame(width: 124, height: 124)
                .scaledToFill()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.navyBlue, lineWidth: 3.0)
                }
        } else {
            Image("DefaultProfileImage")
                .resizable()
                .frame(width: 124, height: 124)
                .scaledToFit()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.navyBlue, lineWidth: 3.0)
                }
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.MOCK_USERS[0])
}
