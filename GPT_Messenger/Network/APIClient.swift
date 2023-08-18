//
//  APIClient.swift
//  GPT_Messenger
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidResponse(statusCode: Int, response: String)
}
// this class is responsible for calling the URLSession publisher and decode the response with JSONDecoder type and return it to upper layer
struct APIClient {
    // Other methods

    func fetchData<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    let responseString = String(data: data, encoding: .utf8) ?? "Invalid Response Data"
                    throw APIError.invalidResponse(statusCode: statusCode, response: responseString)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print("Decoding Error: \(error)") // Print the decoding error
                return error
            }
            .eraseToAnyPublisher()
    }
}










