//
//  ListLayout.swift
//  08. Moonshot
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink(value: mission) {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.leading)
                }
            }
            .listRowBackground(Color.darkBackground)
            .navigationDestination(for: Mission.self) {
                MissionView(mission: $0, astronauts: astronauts)
            }
        }
        .listStyle(.plain)
    }
}
