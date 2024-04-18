//
//  ContentView.swift
//  M3. Habit Tracker
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink(value: activity) {
                        VStack(alignment: .leading) {
                            Text(activity.name)
                                .font(.headline)
                            Text(activity.description)
                                .foregroundStyle(.gray.secondary)
                            Text(String(activity.count))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddActivity.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddActivity) {
                AddActivityView(activity: activities)
            }
            .navigationDestination(for: ActivityItem.self) {
                EditActivityView(activities: activities, activityItem: $0)
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        activities.activities.remove(atOffsets: indexSet)
    }
}

#Preview {
    ContentView()
}
