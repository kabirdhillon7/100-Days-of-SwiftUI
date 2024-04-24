//
//  ContentView.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import Observation
import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var viewModel: ContentViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = ContentViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        UserListView(user: user)
                    }
                }
            }
            .navigationTitle("UserList")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: {
                viewModel.getUsers()
            })
            .navigationDestination(for: User.self) {
                UserDetailView(user: $0)
            }
        }
    }
}

extension ContentView {
    @Observable final class ContentViewModel {
        
        var modelContext: ModelContext
        var users = [User]()
        let networkingCaller = NetworkingCaller()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        func getUsers() {
            Task {
                do {
                    let users = try await networkingCaller.fetchUsers().get()
                    for user in users {
                        modelContext.insert(user)
                    }
                    self.users = users
                } catch let error {
                    print("Error getting users: \(error)")
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        return ContentView(modelContext: container.mainContext).modelContainer(container)
    } catch {
        return Text("Failed to create preview")
    }
}
