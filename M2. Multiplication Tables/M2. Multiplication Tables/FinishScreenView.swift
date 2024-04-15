//
//  FinishScreenView.swift
//  M2. Multiplication Tables
//
//  Created by Kabir Dhillon on 4/11/24.
//

import SwiftUI

struct FinishScreenView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var shouldNavigate: Bool
    @State private var animation = 1.0
    @State private var scale = 1.0
    
    init(shouldNavigate: Binding<Bool>) {
        _shouldNavigate = shouldNavigate
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.green.gradient)
                    .ignoresSafeArea()
                Text("Completed 🎉")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .scaleEffect(scale)
                    .animation(.linear(duration: 0.5), value: scale)
            }
            .overlay(alignment: .bottom) {
                Button {
                    withAnimation {
                        animation += 0.5
                        scale += 2.0
                    }
                    withAnimation(.default.delay(0.5)) {
                        animation = 1.0
                        scale = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.shouldNavigate = false
                        dismiss.callAsFunction()
                    }
                } label: {
                    Text("Exit")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.black)
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .buttonBorderShape(.capsule)
                .scaleEffect(animation)
                .animation(.easeInOut, value: animation)
                .padding()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack {
        FinishScreenView(shouldNavigate: .constant(true))
    }
}
