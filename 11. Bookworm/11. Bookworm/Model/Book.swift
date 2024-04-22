//
//  Book.swift
//  11. Bookworm
//
//  Created by Kabir Dhillon on 4/19/24.
//

import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    let date: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
