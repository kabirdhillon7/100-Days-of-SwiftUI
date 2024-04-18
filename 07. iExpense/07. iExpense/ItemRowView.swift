//
//  ItemView.swift
//  07. iExpense
//
//  Created by Kabir Dhillon on 4/17/24.
//

import SwiftUI

struct ItemRowView: View {
    var item: ExpenseItem
    
    var body: some View {
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

//#Preview {
//    itemView()
//}
