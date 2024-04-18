//
//  Activity.swift
//  M3. Habit Tracker
//
//  Created by Kabir Dhillon on 4/17/24.
//

import Foundation
import Observation

struct ActivityItem: Codable, Identifiable, Equatable, Hashable {
    let id = UUID()
    var name: String
    var description: String
    var count: Int
}

@Observable
final class Activities {
    
    var activities = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.setValue(encoded, forKey: "Activities")
            }
        }
    }
    
    init(activities: [ActivityItem] = [ActivityItem]()) {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([ActivityItem].self, from: savedActivities) {
                self.activities = decodedActivities
                return
            }
        }
        
        self.activities = [ActivityItem]()
    }
}
