//
//  User.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
