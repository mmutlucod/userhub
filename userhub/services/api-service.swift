//
//  APIService.swift
//  userhub
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

class APIService {
    
    static let shared = APIService()
    private init() {}
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "\(baseURL)/users") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError("Server returned error")
            }
        
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
            
        } catch let error as DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw error
        }
    }
    
    func login(email: String, password: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return email == "test@example.com" && password == "123456"
    }
}
