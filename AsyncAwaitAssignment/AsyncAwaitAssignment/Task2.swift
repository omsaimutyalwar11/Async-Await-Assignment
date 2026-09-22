//
//  Task2.swift
//  AsyncAwaitAssignment
//
//  Created by Omsai Mutyalwar on 22/09/26.
//
//
/*
 2. Fetch + decode from a real API

 You have to fetch data from a public API, store it into a decodable data model, decode the data using
 JsonDecoder, and print the data on screen. Use the async-await mechanism to make the network calls
 and also implement the error handling for it.

 API endpoint: https://jsonplaceholder.typicode.com/users
 This endpoint gives a JSON response containing data of users
 Store and print the names and a few other properties of a user.
 */

import Foundation

// A hash map which stores the user data based on id.
var usersByID: [Int: User] = [:]

// Protocol for the User service.
protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

// Implementing the service class
final class UserService: UserServiceProtocol {

    private let session: URLSession
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchUsers() async throws -> [User] {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = "/users"

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await send(request)
        let users = try decode([User].self, from: data)
        return users
    }

    private func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, urlResponse) = try await session.data(for: request)

            guard let http = urlResponse as? HTTPURLResponse else {
                throw NetworkError.transport("Invalid response")
            }

            switch http.statusCode {
            case 200..<300:
                return (data, http)
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.badStatus(http.statusCode)
            }
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.transport(
                error.localizedDescription
            )
        }
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
