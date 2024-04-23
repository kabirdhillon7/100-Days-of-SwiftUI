//
//  ContentView.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/15/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    @State private var showingAddExpense = false
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var expenseTypes = "All"
    
    var body: some View {
        NavigationStack {
            ItemsListView(
                items: items,
                sortOrder: sortOrder,
                expenseType: expenseTypes
            )
//                ForEach(items) { item in
//                    ItemRowView(item: item)
//                }
//                .onDelete(perform: { indexSet in
//                    removeItems(at: indexSet)
//                })
//                Section {
//                    ForEach(expenses.items) { item in
//                        if item.type == "Business" {
//                            NavigationLink(value: item, label: {
//                                ItemRowView(item: item)
//                            })
//                        }
//                    }
//                    .onDelete(perform: { indexSet in
//                        removeItems(at: indexSet)
//                    })
//                } header: {
//                    Text("Business")
//                }
//                Section {
//                    ForEach(expenses.items) { item in
//                        if item.type == "Personal" {
//                            NavigationLink(value: item, label: {
//                                ItemRowView(item: item)
//                            })
//                        }
//                    }
//                    .onDelete(perform: { indexSet in
//                        removeItems(at: indexSet)
//                    })
//                } header: {
//                    Text("Personal")
//                }
            .navigationTitle("iExpense")
            .toolbar {
                Menu("Menu", systemImage: "ellipsis") {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense.toggle()
                    }
                   
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount)
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                    
                    Picker("View Expenses", selection: $expenseTypes) {
                        Text("View All")
                            .tag("All")
                        Text("View Business")
                            .tag("Business")
                        Text("View Personal")
                            .tag("Personal")
                    }
                }
                
            }
//            .navigationDestination(for: ExpenseItem.self) {
//                ItemDetailView(item: $0)
//            }
            .navigationDestination(isPresented: $showingAddExpense, destination: {
                AddView()
            })
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
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
