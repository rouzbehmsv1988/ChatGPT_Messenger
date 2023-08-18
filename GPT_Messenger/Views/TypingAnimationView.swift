//
//  TypingAnimationView.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 17.08.23.
//

import SwiftUI

struct TypingAnimationView: View {
    @State private var dot1Offset: CGFloat = 0
    @State private var dot2Offset: CGFloat = 0
    @State private var dot3Offset: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 8, height: 8)
                .offset(y: dot1Offset)
            
            Circle()
                .frame(width: 8, height: 8)
                .offset(y: dot2Offset)
            
            Circle()
                .frame(width: 8, height: 8)
                .offset(y: dot3Offset)
        }
        .onAppear {
            animateDots()
        }
    }
    
    private func animateDots() {
        withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
            dot1Offset = -6
            dot2Offset = 6
            dot3Offset = -6
        }
    }
}
