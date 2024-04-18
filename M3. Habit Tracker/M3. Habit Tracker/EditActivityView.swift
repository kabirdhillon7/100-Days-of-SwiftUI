//
//  EditActivityView.swift
//  M3. Habit Tracker
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct EditActivityView: View {
    @Bindable var activities: Activities
    @State var activityItem: ActivityItem
    
    var body: some View {
        Form {
            Text(activityItem.name)
            Text(activityItem.description)
            
            Stepper(
                "Completed \(activityItem.count) times",
                onIncrement: {
                    self.stepperUpdated(by: 1)
                },
                onDecrement: {
                    self.stepperUpdated(by: -1)
                }
            )
        }
        .navigationTitle("Edit Activity")
        .toolbarTitleDisplayMode(.large)
    }
    
    func stepperUpdated(by val: Int) {
        activityItem.count += val
        guard let index = activities.activities.firstIndex(where: { $0.id == activityItem.id }) else { return }
        print("Updating Activity Item: \(activityItem.id)")
        activities.activities[index].count += val
    }
}

//#Preview {
//    EditActivityView(activity: Activities())
//}
