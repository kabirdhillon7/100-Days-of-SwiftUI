//
//  Networking.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import Foundation

enum Networking {
    static let url = "https://www.hackingwithswift.com/samples/friendface.json"
}
final class NetworkingCaller {
    
    func fetchUsers() async -> Result<[User], Error> {
        guard let url = URL(string: Networking.url) else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let users = try decoder.decode([User].self, from: data)
            return .success(users)
        } catch let error {
            return .failure(error)
        }
    }
}
