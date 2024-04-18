//
//  AddActivityView.swift
//  M3. Habit Tracker
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @FocusState private var keyboardFocus: KeyboardFocus?
    
    var activity: Activities
    
    enum KeyboardFocus {
        case name, description
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("", text: $name, prompt: Text(verbatim: "Enter a habit name"))
                    .focused($keyboardFocus, equals: .name)
                
                TextField("", text: $description, prompt: Text(verbatim: "Enter a habit description"))
                    .focused($keyboardFocus, equals: .description)
            }
            .navigationTitle("Add Activity")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !name.isEmpty, !description.isEmpty {
                            activity.activities.append(
                                ActivityItem(
                                    name: name,
                                    description: description,
                                    count: 0
                                )
                            )
                            
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(placement: .keyboard) {
                    Button {
                        keyboardFocus = nil
                    } label: {
                        Text("Done")
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddActivityView(activity: Activities())
    }
}
