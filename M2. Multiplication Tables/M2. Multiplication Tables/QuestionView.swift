//
//  QuestionView.swift
//  M2. Multiplication Tables
//
//  Created by Kabir Dhillon on 4/10/24.
//

import SwiftUI

final class QuestionViewModel: ObservableObject {
    @Published var range: (Int, Int)
    @Published var input = ""
    @Published var currentQuestion = 1
    var totalQuestions: Int
    
    @Published var nums: [(Int, Int)] = []
    
    init(range: (Int, Int), totalQuestions: Int) {
        self.range = range
        self.totalQuestions = totalQuestions
        
        for _ in 0...totalQuestions {
            self.nums.append((Int.random(in: range.0...range.1), Int.random(in: 2...12)))
        }
    }
    
    func checkSum() -> Bool {
        return (nums[currentQuestion].0 * nums[currentQuestion].1) == Int(input)
    }
    
    func refresh() {
        self.currentQuestion += 1
        self.input = ""
    }
}

struct QuestionView: View {
    @ObservedObject private var viewModel: QuestionViewModel
    @Binding private var shouldNavigate: Bool
    @FocusState private var keyboardFocused: Bool
    
    @State private var animation = 1.0
    @State private var quitAnimation = 1.0
    @State private var incorrectAnswerAlert = false
    @State private var buttonDisabled = true
    @State var shouldNavigateToFinishScreen = false
    
    init(viewModel: QuestionViewModel, shouldNavigate: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _shouldNavigate = shouldNavigate
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.purple.quaternary)
                    .ignoresSafeArea()
                VStack {
                    Text("Question \(viewModel.currentQuestion) / \(viewModel.totalQuestions)")
                        .font(.largeTitle.bold())
                        .scaleEffect(animation)
                        .animation(.linear, value: animation)
                    
                    Spacer()
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        let numVal = viewModel.nums[viewModel.currentQuestion]
                        
                        Text("\(numVal.0) x \(numVal.1) =")
                            .font(.largeTitle.weight(.medium))
                        
                        TextField("", text: $viewModel.input)
                            .font(.largeTitle)
                            .keyboardType(.decimalPad)
                            .focused($keyboardFocused)
                            .onSubmit {
                                let result = viewModel.checkSum()
                                if result {
                                    buttonDisabled = false
                                    keyboardFocused = false
                                } else {
                                    incorrectAnswerAlert = true
                                }
                            }
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.5)
                    }
                    Spacer()
                }
                .padding()
            }
            .overlay(alignment: .bottom, content: {
                Button {
                    withAnimation {
                        animation += 0.5
                    }
                    withAnimation(.default.delay(0.50)) {
                        animation = 1.0
                    }
                    
                    if viewModel.currentQuestion == viewModel.totalQuestions {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            shouldNavigateToFinishScreen = true
                        }
                    } else {
                        withAnimation {
                            viewModel.refresh()
                            buttonDisabled = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                keyboardFocused = true
                            }
                        }
                    }
                } label: {
                    Text("Continue")
                        .font(.title.weight(.semibold))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                }
                .disabled(buttonDisabled)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .scaleEffect(animation)
                .animation(.easeInOut, value: animation)
                .padding()
            })
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $shouldNavigateToFinishScreen) {
                FinishScreenView(shouldNavigate: $shouldNavigate)
            }
            .alert("Incorrect Answer", isPresented: $incorrectAnswerAlert, actions: { }, message: {
                Text("Please try again")
            })
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    keyboardFocused = true
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        withAnimation {
                            quitAnimation += 0.5
                        }
                        withAnimation(.default.delay(0.50)) {
                            quitAnimation = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            shouldNavigate = false
                        }
                    } label: {
                        Label("", systemImage: "xmark")
                            .foregroundStyle(.white)
                    }
                    .buttonBorderShape(.circle)
                    .buttonStyle(.borderedProminent)
                    .scaleEffect(quitAnimation)
                    .animation(.easeInOut, value: quitAnimation)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuestionView(viewModel: QuestionViewModel(range: (4, 10), totalQuestions: 4), shouldNavigate: .constant(true))
    }
}

#Preview {
    NavigationStack {
        QuestionView(viewModel: QuestionViewModel(range: (4, 5), totalQuestions: 2), shouldNavigate: .constant(true))
    }
}
