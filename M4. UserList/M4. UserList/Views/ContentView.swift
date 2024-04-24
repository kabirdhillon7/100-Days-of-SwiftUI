//
//  ContentView.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import Observation
import SwiftUI

@Observable final class ContentViewModel {
    var users = [User]()
    let networkingCaller = NetworkingCaller()
    
    func getUsers() {
        Task {
            do {
                let users = try await networkingCaller.fetchUsers().get()
                self.users = users
            } catch let error {
                print("Error getting users: \(error)")
            }
        }
    }
}

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users, id: \.id) { user in
                    UserListView(user: user)
                }
            }
            .navigationTitle("UserList")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: {
                viewModel.getUsers()
            })
        }
    }
}

#Preview {
    ContentView()
}
