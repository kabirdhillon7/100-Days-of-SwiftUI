//
//  M5__EventContactsApp.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 5/31/24.
//

import SwiftUI

@main
struct EventContactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Contact.self)
    }
}
