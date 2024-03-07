//
//  EditPortfolioView.swift
//  SkillSync
//
//  Created by Prem Balani on 12/16/23.
//

import SwiftUI

struct EditPortfolioView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sync your Portfolio")
                    .font(.custom("Lato-Black", size: 24))
                    .foregroundStyle(.navyBlue)
                Text("Select the category to add content to your portfolio")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundStyle(.companyOrange)
            }
            .padding(.leading, 40)
            .padding(.vertical, 60)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    EditPortfolioView()
}
