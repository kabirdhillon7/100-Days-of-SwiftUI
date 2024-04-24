//
//  UserListView.swift
//  M4. UserList
//
//  Created by Kabir Dhillon on 4/23/24.
//

import SwiftUI

struct UserListView: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.name)
                .foregroundStyle(.primary)
            Spacer()
            Image(systemName: user.isActive ? "circle.fill" : "circle")
                .foregroundStyle(user.isActive ? .green : .red)
        }
    }
}

#Preview {
    UserListView(
        user: User(
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
        )
    )
}
