//
//  AddEditViewModel.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 10/7/25.
//

import SwiftUI
import SwiftData

@MainActor
class AddEditViewModel: ObservableObject {

    private var bookToEdit:PersistentBook?
    private let modelContext: ModelContext
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var summary: String = ""
    @Published var rating: Int = 0
    @Published var review: String = ""
    @Published var status: ReadingStatus = .unknown
    @Published var genre: Genre = .unknown
    @Published var isFavorite: Bool = false
    @Published var cover: UIImage? = nil
    
    var navigationTitle: String {
        bookToEdit == nil ? "Add Book" : "Edit Book"
    }
    
    var isSaveButtonDisabled: Bool {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)

         // Title must be nonempty after trimming
         guard !trimmed.isEmpty else { return true }

         // If creating a new book, enabled as soon as the user types a valid title
         guard let existing = bookToEdit else { return false }

         // If editing, enable only when something actually changed

         let unchangedTitle = trimmed == existing.title
         return unchangedTitle
    }
    
    
    init (book: PersistentBook? = nil, modelContext: ModelContext) {
        self.bookToEdit = book
        self.modelContext = modelContext
        
        if let book{
            self.title = book.title
            self.author = book.author
            self.summary = book.summary
            self.rating =   book.rating
            self.review = book.review
            self.status = book.status
            self.genre = book.genre
            self.isFavorite = book.isFavorite
            if let coverData = book.imageData {
                self.cover = UIImage(data: coverData)
            }
        }
        
    }
    
    func save() {
        let isANewBook = bookToEdit == nil
        let bookToSave = bookToEdit ?? PersistentBook(title: "")
        
    }
}
