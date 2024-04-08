//
//  ContentView.swift
//  03. ViewsAndModifiers
//
//  Created by Kabir Dhillon on 4/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Title 1")
                .modifier(LargeBlueTitle())
        }
    }
}

#Preview {
    ContentView()
}

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
    }
}
