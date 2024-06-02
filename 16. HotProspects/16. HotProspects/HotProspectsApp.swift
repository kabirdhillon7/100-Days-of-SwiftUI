//
//  _6__HotProspectsApp.swift
//  16. HotProspects
//
//  Created by Kabir Dhillon on 6/1/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
