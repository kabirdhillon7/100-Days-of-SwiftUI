//
//  ContentView.swift
//  08. Moonshot
//
//  Created by Kabir Dhillon on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var gridToggle = true
    
    var body: some View {
        NavigationStack {
            Group {
                if gridToggle {
                    GridLayout(astronauts: astronauts, missions: missions)
                    
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle(isOn: $gridToggle, label: {
                        Text("Grid")
                    })
                    .toggleStyle(.switch)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
