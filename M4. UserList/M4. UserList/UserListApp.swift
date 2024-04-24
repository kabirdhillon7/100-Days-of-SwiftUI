//
//  M4__UserListApp.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import SwiftData
import SwiftUI

@main
struct UserListApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: User.self)
        } catch {
            fatalError("Failed to create ModelContainer for User.")
        }
    }
}
