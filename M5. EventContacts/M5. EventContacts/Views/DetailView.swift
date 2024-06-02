//
//  DetailView.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 6/1/24.
//

import SwiftUI

struct DetailView: View {
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var body: some View {
        Image(uiImage: ((UIImage(data: contact.photo)) ?? UIImage(systemName: "person"))!)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: 100)
        
        Text(contact.name)
            .font(.title)
            .frame(maxWidth: .infinity)
        
    }
}

