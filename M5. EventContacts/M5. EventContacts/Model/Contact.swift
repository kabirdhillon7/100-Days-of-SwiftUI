//
//  Contact.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 6/1/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    @Attribute(.externalStorage) let photo: Data
    let name: String
    
    init(id: UUID, photo: Data, name: String) {
        self.id = id
        self.photo = photo
        self.name = name
    }
}
