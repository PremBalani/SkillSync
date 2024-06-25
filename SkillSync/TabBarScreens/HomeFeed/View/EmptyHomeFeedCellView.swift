//
//  EmptyHomeFeedCellView.swift
//  SkillSync
//
//  Created by Prem Balani on 6/22/24.
//

import SwiftUI

struct EmptyHomeFeedCellView: View {
    @State var animate: Bool = false
    var body: some View {
        ZStack (alignment: .topLeading) {
            ZStack(alignment: .bottomLeading) {
                ProgressView()
                     .scaledToFill()
                    .frame(width: 300, height: 300)
            }
            .background {
                LinearGradient(colors: [.black.opacity(0.6), .black.opacity(0.4)], startPoint: .bottom, endPoint: .top).frame(width: 1000)
                    .hueRotation(.degrees(animate ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animate.toggle()
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)))
        .padding(.horizontal, 50)
        .padding(.vertical, 15)
        
    }
}

#Preview {
    EmptyHomeFeedCellView()
}
