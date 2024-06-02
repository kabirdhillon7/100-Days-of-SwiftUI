//
//  ContentView.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 5/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var presentAddSheet = false
    @Query(sort: [SortDescriptor(\Contact.name)]) var contacts: [Contact]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts, id: \.id) { contact in
                    NavigationLink(value: contact) {
                        
                        HStack(spacing: 10) {
                            Image(uiImage: ((UIImage(data: contact.photo)) ?? UIImage(systemName: "person"))!)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 75, height: 75)
                            Text(contact.name)
                                .font(.system(size: 21))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteContacts(at: indexSet)
                })
            }
            .navigationTitle("EventContacts")
            .navigationDestination(for: Contact.self){ contact in
                DetailView(contact: contact)
            }
            .toolbar {
                Button(action: {
                    presentAddSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $presentAddSheet, content: {
                AddView { contact in
                    modelContext.insert(contact)
                }
            })
        }
    }
    
    func deleteContacts(at offsets: IndexSet) {
        for offset in offsets {
            // find this contact in our query
            let contact = contacts[offset]
            
            // delete it from the context
            modelContext.delete(contact)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
