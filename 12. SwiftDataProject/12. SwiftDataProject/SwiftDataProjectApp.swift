//
//  _2__SwiftDataProjectApp.swift
//  12. SwiftDataProject
//
//  Created by Kabir Dhillon on 4/23/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
