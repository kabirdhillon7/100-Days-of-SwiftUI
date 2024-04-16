//
//  ContentView.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(fontStyling(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                } header: {
                    Text("Business")
                }
                Section {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(fontStyling(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                } header: {
                    Text("Personal")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func fontStyling(_ val: Double) -> Color {
        if val < 10.0 {
            return .green
        } else if val > 10.0 && val < 100.0 {
            return .orange
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
}
