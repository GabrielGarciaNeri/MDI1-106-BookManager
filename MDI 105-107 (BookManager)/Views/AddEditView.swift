//
//  EditView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct AddEditView: View {

   // @StateObject private var viewModel: AddEditViewModel will be added
    // @Enviroment(\.dismiss) var dismiss will be added
    
    
    // If non-nil we are editing, otherwise adding
    var book: PersistentBook? = nil

    @State var workingBook: PersistentBook

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var navigationTitle: String
    @State private var cover: UIImage? = nil

    init(book: PersistentBook? = nil) {
        self.book = book // _viewModel = StateObject( wrappedvalue: addeditviewmodel adding model context here

        // Working model
        _workingBook = State(initialValue: book ?? PersistentBook(title: "")) //its no longer copying check addeditviewmodel

        // Corrected: if book exists => "Edit Book", else "Add Book"
        _navigationTitle = State(initialValue: book == nil ? "Add Book" : "Edit Book") //has been added to addeditviewmodel

       
        if let data = book?.imageData, let ui = UIImage(data: data) { //has been added to addeditviewmodel differently
            _cover = State(initialValue: ui)
        } else {
            _cover = State(initialValue: nil)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )

                Form {
                    Section(header: Text("Book Cover")) {
                        ImageField(image: $cover)
                    }

                    Section(header: Text("Book Details")) {
                        TextField("Title of the book", text: $workingBook.title) //workingbook will mostlikely change to viewmodel
                        TextField("Author", text: $workingBook.author)

                        Picker("Genre", selection: $workingBook.genre) {
                            ForEach(Genre.allCases, id: \.self) { g in
                                Text(g.rawValue).tag(g)
                            }
                        }

                        Picker("Status", selection: $workingBook.status) {
                            ForEach(ReadingStatus.allCases, id: \.self) { s in
                                Text(s.rawValue).tag(s)
                            }
                        }

                        //  NEW: Favorite toggle (works for both Add & Edit)
                        Toggle("Mark as Favorite", isOn: $workingBook.isFavorite)

                        TextEditor(text: $workingBook.summary)
                            .frame(height: 100)
                    }

                    Section(header: Text("My review")) {
                        StarRatingView(rating: $workingBook.rating)
                        TextEditor(text: $workingBook.review)
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(workingBook.title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    // MARK: - Save

    private func save() {
        let isNew = (book == nil)
        let bookToSave = book ?? PersistentBook(title: "")

        // Persist fields from workingBook -> stored model
        bookToSave.title = workingBook.title
        bookToSave.author = workingBook.author
        bookToSave.genre = workingBook.genre
        bookToSave.status = workingBook.status
        bookToSave.rating = workingBook.rating
        bookToSave.review = workingBook.review
        bookToSave.isFavorite = workingBook.isFavorite  // persist favorite flag

        if let cover {
            bookToSave.imageData = cover.jpegData(compressionQuality: 0.8)
        }

        do {
            if isNew {
                modelContext.insert(bookToSave)
            }
            try modelContext.save()
        } catch {
            print("Failed to save book: \(error)")
        }

        dismiss()
    }
}
