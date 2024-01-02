//
//  ProfileView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("IconImage")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.oliveGreen, lineWidth: 4.0)
            }
        }
    }
}

#Preview {
    ProfileView()
}
