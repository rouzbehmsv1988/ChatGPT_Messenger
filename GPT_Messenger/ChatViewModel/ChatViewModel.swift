//
//  ChatViewModel.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 17.08.23.
//

import Foundation
import Combine
                  
@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var isTyping = false
    func sendMessage(message: String) {
        isTyping = true
        let userMessage = ChatMessage(role: "user", content: message)
        messages.append(userMessage) // Add user's message

        // Create API request and handle response
        APIManager<ChatbotResponse>.shared.request(.sendMessage(message: message))
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                DispatchQueue.main.async { [weak self] in
                    self?.handleApiResponse(response)
                }
                     
            }).store(in: &cancellables)
    }

    private func handleApiResponse(_ response: ChatbotResponse) {
        guard let message = response.choices?.first?.message else {
            // Handle invalid response
            return
        }
        isTyping = false
        let chatbotMessage = ChatMessage(role: "chatbot", content: message.content)
        messages.append(chatbotMessage) // Add chatbot's message
    }
}
