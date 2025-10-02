//
//  EditView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct AddEditView: View {
    
    var book: PersistentBook? = nil
    @State var workingBook: PersistentBook
    @Environment(\.dismiss) var dismiss
    @State private var navigationTitle: String
    @State private var cover: UIImage? = nil
    
    
    @Environment(\.modelContext) private var modelContext
    
    init(book: PersistentBook? = nil){
        self.book = book
        _workingBook = .init(initialValue: book ?? PersistentBook(title: ""))
        self._navigationTitle = State(initialValue: book != nil ? "Add Book" : "Edit Book")
        if(book?.imageData != nil){
            cover = UIImage(data: book!.imageData!)
        }
    }
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                Form{
                    Section(header: Text("BookCover")) {
                        ImageField(image: $cover)
                    }
                    Section(header: Text("Book Details")) {
                        TextField("Title of the book", text: $workingBook.title)
                        TextField("Author", text: $workingBook.author)
                        Picker("Genre", selection: $workingBook.genre){
                            ForEach(Genre.allCases, id: \.self){ status in
                                Text(status.rawValue).tag(status)
                            }
                        }
                        Picker("Status", selection: $workingBook.status){
                            ForEach(ReadingStatus.allCases, id: \.self) { status in
                                Text(status.rawValue).tag(status)
                                
                            }
                        }
                        TextEditor(text: $workingBook.summary)
                            .frame(height: 100)
                    }
                    Section(header: Text("My review")){
                        
                        StarRatingView(rating: $workingBook.rating)
                        TextEditor(text: $workingBook.review)
                            .frame(height: 150)
                    }
                }
                
            }.navigationTitle(navigationTitle)
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save") {
                            let isANewBook = book == nil
                            let bookToSave = book ?? PersistentBook(title:"")
//                            if (cover != nil){
//                                    let newImage = UploadedImage(
//                                        imageName:"image for \(workingBook.title)",
//                                        imageData: cover?.jpegData(compressionQuality: 0.8))
//                                    do {
//                                        modelContext.insert(newImage)
//                                        try modelContext.save()
//                                    } catch {
//                                        print("Failed to save image: \(error)")
//                                    }
//                                    workingBook.imageData = newImage.imageData
//                                }
                                bookToSave.title = workingBook.title
                                bookToSave.author = workingBook.author
                                bookToSave.genre = workingBook.genre
                                bookToSave.status = workingBook.status
                                bookToSave.rating = workingBook.rating
                                bookToSave.review = workingBook.review
                            if(cover != nil){
                                bookToSave.imageData = cover?.jpegData(compressionQuality: 0.8)
                            }
                               
                                do {
                                    if (isANewBook){
                                        let _ = print("We are creating a new book")
                                        modelContext.insert(bookToSave)
                                    }
                                    
                                    try modelContext.save()
                                } catch {
                                    print("Failed to save image: \(error)")
                                }

                                dismiss()
                            }
                                .disabled(workingBook.title.isEmpty)
                        }
                    }
                }
        }
    }

