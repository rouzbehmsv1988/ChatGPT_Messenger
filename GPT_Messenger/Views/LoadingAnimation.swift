//
//  LoadingAnimation.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 18.08.23.
//

import SwiftUI

struct LoadingAnimation: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcom to your own GPT experience")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
            Spacer()
        }
        .opacity(0.8) // Adjust opacity as needed
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
