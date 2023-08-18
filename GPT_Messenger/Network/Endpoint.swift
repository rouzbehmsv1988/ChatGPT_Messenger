//
//  Endpoint.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation

// you can input your baseURL and API Key here inorder to have access to the API service you want
import Foundation

enum Endpoint {
    static let baseURL = URL(string: "https://api.openai.com")!
    static let headers: [String: String] = [
          "Authorization": "Bearer API KEY",
          "Content-Type": "application/json"
      ]
    case sendMessage(message: String)

    enum MethodTypes: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    var path: String {
        switch self {
        case .sendMessage:
            return "/v1/chat/completions"
        }
    }

    var method: MethodTypes {
        switch self {
        case .sendMessage:
            return .post
        }
    }

    var request: URLRequest {
        let url = Endpoint.baseURL.appendingPathComponent(path) 
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = Endpoint.headers

        switch self {
        case .sendMessage(let message):
            let requestData: [String: Any] = [
                "messages": [
                    ["role": "system", "content": "You are a chatbot"],
                    ["role": "user", "content": message]
                ],
                "model": "gpt-3.5-turbo"
            ]

            if let jsonData = try? JSONSerialization.data(withJSONObject: requestData) {
                request.httpBody = jsonData
            }
        }

        return request
    }
}
