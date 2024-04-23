//
//  ItemsListView.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/23/24.
//

import SwiftData
import SwiftUI

struct ItemsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    
    init(items: [ExpenseItem], sortOrder: [SortDescriptor<ExpenseItem>], expenseType: String) {
        _items = Query(
            filter: #Predicate<ExpenseItem> { item in
                expenseType == "All" ? true : item.type == expenseType
            },
            sort: sortOrder
        )
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(value: item) {
                    ItemRowView(item: item)
                }
            }
            .onDelete(perform: { indexSet in
                removeItems(at: indexSet)
            })
        }
        .navigationDestination(for: ExpenseItem.self) {
            ItemDetailView(item: $0)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = items[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        
        let items = [ExpenseItem(name: "Ice Cream", type: "Personal", amount: 8.00)]
        let sortOrder = [
            SortDescriptor(\ExpenseItem.name),
            SortDescriptor(\ExpenseItem.amount)
        ]
        
        return ItemsListView(
            items: items,
            sortOrder: sortOrder,
            expenseType: "All"
        ).modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
