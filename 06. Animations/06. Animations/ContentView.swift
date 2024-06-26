//
//  ContentView.swift
//  06. Animations
//
//  Created by Kabir Dhillon on 4/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    @State private var isShowingRed = false
    
    var body: some View {
        NavigationStack {
            List {
                Button("Tap Me") {
                    //                animationAmount += 1
                }
                .padding(50)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .opacity(2 - animationAmount)
                        .animation(
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: animationAmount
                        )
                )
                .onAppear {
                    animationAmount = 2
                }
                
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                    
                    if isShowingRed {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200, height: 200)
                            .transition(.pivot)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
            }
            .navigationTitle("Animations")
        }
    }
}

#Preview {
    ContentView()
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
