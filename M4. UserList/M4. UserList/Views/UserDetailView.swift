//
//  UserDetailView.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: user.isActive ? "circle.fill" : "circle")
                        .foregroundStyle(user.isActive ? .green : .red)
                    Text(user.isActive ? "Active" : "Away")
                        .foregroundStyle(user.isActive ? .green : .red)
                }
                .padding(.bottom, 10)
                
                Text("Age")
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(String(user.age))
                    .padding(.bottom, 10)
                
                Text("About")
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(user.about)
                    .padding(.bottom, 10)
                
                Text("Company")
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(user.company)
                    .padding(.bottom, 10)
                
                Text("Email")
                    .font(.headline)
                    .padding(.bottom, 1)
                if let emailUrl = URL(string: user.email) {
                    Link("\(user.email)", destination: emailUrl)
                        .padding(.bottom, 10)
                } else {
                    Text(user.email)
                        .padding(.bottom, 10)
                }
                
                Text("Address")
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(user.address)
                    .padding(.bottom, 10)
                
                Text("Registered")
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(user.registered.formatted(date: .abbreviated, time: .shortened))
                    .padding(.bottom, 10)
                
                Text("Tags")
                    .font(.headline)
                    .padding(.bottom, 1)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            ZStack {
                                Capsule()
                                    .fill(.blue)
                                Text(tag)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
                .padding(.bottom, 10)
                
                Text("Friends")
                    .font(.headline)
                    .padding(.bottom, 1)
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.large)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: User(
            id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
            isActive: false,
            name: "Alford Rodriguez",
            age: 21,
            company: "Imkan",
            email: "alfordrodriguez@imkan.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            registered: Date.now,
            tags: [
                "cillum",
                "consequat",
                "deserunt",
                "nostrud",
                "eiusmod",
                "minim",
                "tempor"
            ],
            friends: [Friend(id: "7ef1899e-96e4-4a76-8047-0e49f35d2b2c", name: "Josefina Rivas")]
        ))
    }
}
