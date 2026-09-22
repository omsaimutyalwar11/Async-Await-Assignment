//
//  NetworkError.swift
//  AsyncAwaitAssignment
//
//  Created by Omsai Mutyalwar on 22/09/26.
//

import Foundation

enum NetworkError: Error, Equatable {

    case invalidURL
    case notFound
    case badStatus(Int)
    case offline
    case decodingFailed
    case transport(String)

    var userMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL error."
        case .notFound:
            return "Users not found."
        case .badStatus(let code):
            return "Server error (\(code)). Please try again."
        case .offline:
            return "You appear to be offline. Check your connection and try again."
        case .decodingFailed:
            return "The server sent data in a format the app did not expect."
        case .transport(let detail):
            return "Could not reach the server. \(detail)"
        }
    }
}
