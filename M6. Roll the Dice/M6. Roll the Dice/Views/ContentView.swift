//
//  ContentView.swift
//  M6. Roll the Dice
//
//  Created by Kabir Dhillon on 6/4/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var diceCount: Int = 1
    @State private var sidesCount: Int = 4
    @Query var rolls: [DiceRoll]
    @State private var diceBtnTapped = false
    
    let sideOptions = [4, 8, 10, 12, 20, 100]
    var body: some View {
        NavigationStack {
            VStack {
                diceSelection
                sidesSelection
                diceRollHistory
            }
            .navigationTitle("Roll the Dice")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        do {
                            try modelContext.delete(model: DiceRoll.self)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                }
            }
            .overlay(alignment: .bottom) {
                Button(action: {
                    diceBtnTapped.toggle()
                    rollDice()
                }, label: {
                    Label("Roll", systemImage: "dice")
                        .labelStyle(.titleAndIcon)
                        .fixedSize()
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .sensoryFeedback(.start, trigger: diceBtnTapped)
            }
        }
    }
    
    @ViewBuilder
    var diceSelection: some View {
        Text("Dice")
            .font(.system(size: 21))
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        Picker("Dice", selection: $diceCount) {
            ForEach(1..<6) { num in
                Text(String(num))
                    .tag(num)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var sidesSelection: some View {
        Text("Sides")
            .font(.system(size: 21))
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        Picker("Sides", selection: $sidesCount) {
            ForEach(sideOptions, id: \.self) { num in
                Text(String(num))
                    .tag(num)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    var diceRollHistory: some View {
        List {
            ForEach(rolls.reversed(), id: \.self) { roll in
                HStack{
                    ForEach(roll.rolls, id: \.self) { num in
                        Text(String(num))
                    }
                }
            }
        }
    }
    
    func rollDice()  {
        var results = [Int]()
        var total = 0
        for _ in 0..<diceCount {
            let roll = Int.random(in: 1...sidesCount)
            total += roll
            results.append(roll)
        }
        
        let diceRoll = DiceRoll(
            id: UUID(),
            total: total,
            rolls: results
        )
        modelContext.insert(diceRoll)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DiceRoll.self)
}
