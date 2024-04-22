//
//  AddBookView.swift
//  11. Bookworm
//
//  Created by Kabir Dhillon on 4/19/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var disabledButton: Bool {
        return title.isEmpty || author.isEmpty || review.isEmpty
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(
                            title: title,
                            author: author,
                            genre: genre,
                            review: review,
                            rating: rating, 
                            date: Date.now
                        )
                        
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                }
                .disabled(disabledButton)
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
