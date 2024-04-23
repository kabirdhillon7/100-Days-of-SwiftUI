//
//  ItemDetailView.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct ItemDetailView: View {
    @State var item: ExpenseItem
    
    init(item: ExpenseItem) {
        _item = State(initialValue: item)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.type)
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        .navigationTitle($item.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}
