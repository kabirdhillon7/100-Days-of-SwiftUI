//
//  ContentView.swift
//  M2. Multiplication Tables
//
//  Created by Kabir Dhillon on 4/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var beginRange = 2
    @State private var endRange = 12
    @State private var questionSelection = 1
    let questionsOptions = [1, 5, 10, 20]
    
    @State private var animation = 1.0
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Stepper("\(beginRange.formatted())", value: $beginRange, in: 2...12, step: 1)
                    Text("up to...")
                    Stepper("\(endRange.formatted())", value: $endRange, in: 2...12, step: 1)
                }
                Picker("How many questions?", selection: $questionSelection) {
                    ForEach(questionsOptions, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                Button {
                    withAnimation {
                        animation += 0.5
                    }
                    withAnimation(.default.delay(0.5)) {
                        animation = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        shouldNavigate = true
                    }
                } label: {
                    Text("Start")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .buttonBorderShape(.capsule)
                .scaleEffect(animation)
                .animation(.easeInOut, value: animation)
            }
            .navigationTitle("Multiplication")
            .padding()
            .navigationDestination(isPresented: $shouldNavigate) {
                QuestionView(viewModel: QuestionViewModel(range: (beginRange, endRange), totalQuestions: questionSelection), shouldNavigate: $shouldNavigate)
            }
        }
    }
}

#Preview {
    ContentView()
}
