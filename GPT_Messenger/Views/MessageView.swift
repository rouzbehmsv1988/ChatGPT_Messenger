//
//  MessageView.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 17.08.23.
//

import SwiftUI

struct MessageView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
               if message.role == "user" {
                   Spacer()
                   Text(message.content ?? "")
                       .chatBubble(isUser: true)
               } else {
                   Text(message.content ?? "")
                       .chatBubble(isUser: false)
                   Spacer()
               }
        }.background(Color.clear.opacity(0.1))
           
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        let message = ChatMessage(role: "user", content: "Hi")
        MessageView(message: message)
    }
}
