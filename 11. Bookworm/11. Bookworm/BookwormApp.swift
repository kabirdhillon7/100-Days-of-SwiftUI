//
//  _1__BookwormApp.swift
//  11. Bookworm
//
//  Created by Kabir Dhillon on 4/18/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
