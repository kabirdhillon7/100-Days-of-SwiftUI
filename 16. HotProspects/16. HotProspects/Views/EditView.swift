//
//  EditView.swift
//  16. HotProspects
//
//  Created by Kabir Dhillon on 6/2/24.
//

import SwiftUI

struct EditView: View {
    @Bindable var prospect: Prospect
    @FocusState private var keyboardFocus: KeyboardFocusField?
    
    enum KeyboardFocusField {
        case name, email
    }
    
    init(prospect: Prospect) {
        self.prospect = prospect
    }
    
    var body: some View {
        VStack {
            LabeledContent {
                TextField("Name", text: $prospect.name)
                    .focused($keyboardFocus, equals: .name)
            } label: {
                Text("Name:")
                    .fontWeight(.medium)
            }
            LabeledContent {
                TextField("Email", text: $prospect.emailAddress)
                    .focused($keyboardFocus, equals: .email)
            } label: {
                Text("Email:")
                    .fontWeight(.medium)
            }
        }
        .navigationTitle(prospect.name)
    }
}

#Preview {
    EditView(
        prospect: Prospect(
            name: "Tim Cook",
            emailAddress: "tim.cook@apple.com",
            isContacted: false
        )
    )
}
