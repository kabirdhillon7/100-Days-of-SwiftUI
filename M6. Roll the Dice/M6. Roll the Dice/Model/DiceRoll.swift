//
//  DiceRoll.swift
//  M6. Roll the Dice
//
//  Created by Kabir Dhillon on 6/4/24.
//

import Foundation
import SwiftData

@Model
final class DiceRoll: Comparable {
    static func < (lhs: DiceRoll, rhs: DiceRoll) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    let total: Int
    let rolls: [Int]
    
    init(id: UUID, total: Int, rolls: [Int]) {
        self.id = id
        self.total = total
        self.rolls = rolls
    }
}
