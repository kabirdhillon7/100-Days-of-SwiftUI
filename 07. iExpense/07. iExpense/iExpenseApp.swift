//
//  _7__iExpenseApp.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/15/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
