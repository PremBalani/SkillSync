//
//  CustomInputFieldView.swift
//  SkillSync
//
//  Created by Prem Balani on 3/12/24.
//

import SwiftUI

struct CustomInputFieldView: View {
    @State var title: String
    @State var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.navyBlue)
                .padding(.leading, 12)
            TextField("",
                      text: $text,
                      prompt: Text(placeholder)
                .foregroundStyle(.mediumBlue)
                .font(.custom("Lato-Black", size: 12))
            )
            .foregroundStyle(.mediumBlue)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(12)
            .background(.babyBlue.opacity(0.4))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        }
        .font(.custom("Lato-Black", size: 12))
        .padding(.horizontal, 37)
    }
}
