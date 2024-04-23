//
//  ExpenseItems.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/15/24.
//

import Foundation
import Observation
import SwiftData

@Model
final class ExpenseItem {
    var id = UUID()
    var name: String
    let type: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

@Model
final class Expenses {
    
    @Relationship(deleteRule: .cascade) var items = [ExpenseItem]()
    
    init(items: [ExpenseItem] = [ExpenseItem]()) {
        self.items = items
    }
    
}
