//
//  User.swift
//  userhub
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String?
    
    let username: String?
    let website: String?
}

extension User {
    static let mockUsers = [
        User(id: 1, name: "Ahmet Yılmaz", email: "ahmet@test.com", phone: "555-0001", username: "ahmet", website: nil),
        User(id: 2, name: "Ayşe Demir", email: "ayse@test.com", phone: "555-0002", username: "ayse", website: nil),
        User(id: 3, name: "Mehmet Kaya", email: "mehmet@test.com", phone: "555-0003", username: "mehmet", website: nil)
    ]
}
