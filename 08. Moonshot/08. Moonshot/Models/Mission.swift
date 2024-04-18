//
//  Mission.swift
//  08. Moonshot
//
//  Created by Kabir Dhillon on 4/17/24.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
        
        static func == (lhs: CrewRole, rhs: CrewRole) -> Bool {
            return lhs.name == rhs.name && lhs.role == rhs.role
        }
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
}
