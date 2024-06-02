//
//  Contact.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 6/1/24.
//

import Foundation
import MapKit
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
    let location: Coordinate2D
    
    init(id: UUID, photo: Data, name: String, location: Coordinate2D) {
        self.id = id
        self.photo = photo
        self.name = name
        self.location = location
    }
}

struct Coordinate2D: Codable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
