//
//  ContentView.swift
//  C1. Rock, Paper, Scissors
//
//  Created by Kabir Dhillon on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let winning = ["Paper", "Scissors", "Rock"]
    
    @State private var appMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var playerMove: Int = 0
    @State private var playerScore = 0
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.purple, .blue]))
                .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 10) {
                    VStack {
                        Text("Player Score")
                            .font(.largeTitle.bold())
                        Text(playerScore, format: .number)
                            .fontWeight(.medium)
                    }
                    
                    VStack {
                        Text("App's Move")
                            .font(.largeTitle.bold())
                        Text(moves[appMove])
                            .fontWeight(.medium)
                    }
                    
                    VStack {
                        Text("Should win?")
                            .font(.largeTitle.bold())
                        Text(shouldWin ? "Yes" : "No")
                            .fontWeight(.medium)
                        
                    }
                }
                .foregroundStyle(.white)
                
                Spacer()
                
                ForEach(0..<3, id: \.self) { number in
                    Button {
                        playerMove = number
                        checkMove()
                    } label: {
                        Text(moves[number])
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundStyle(.white)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                
                Spacer()
                 
                Button("Reset", role: .destructive) {
                    resetGame()
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
        }
    }
    
    func checkMove() {
//        if shouldWin {
//            playerScore += appMove != playerMove ? 1 : -1
//        } else {
//            playerScore += appMove == playerMove ? -1 : 1
//        }
        if appMove == playerMove {
            //
        } else if shouldWin && winning[appMove] == moves[playerMove] {
            playerScore += 1
        } else if !shouldWin && winning[playerMove] == moves[appMove] {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        playerScore += 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()

    }
    
    func resetGame() {
        showAlert = false
        playerScore = 0
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
