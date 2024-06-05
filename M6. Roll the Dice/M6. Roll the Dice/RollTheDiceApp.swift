//
//  M6__Roll_the_DiceApp.swift
//  M6. Roll the Dice
//
//  Created by Kabir Dhillon on 6/4/24.
//

import SwiftData
import SwiftUI

@main
struct RollTheDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DiceRoll.self)
    }
}
