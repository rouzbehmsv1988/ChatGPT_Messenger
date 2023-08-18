//
//  ChatbotResponse.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 17.08.23.
//

import Foundation

struct ChatbotResponse: Decodable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let usage: Usage?
    let choices: [ResponseChoice]?
}

struct Usage: Decodable {
    let prompt_tokens: Int?
    let completion_tokens: Int?
    let total_tokens: Int?
}

struct ResponseChoice: Decodable, Hashable {
    let message: ChatMessage
}

struct ChatMessage: Decodable, Hashable {
    let role: String?
    let content: String?
}
