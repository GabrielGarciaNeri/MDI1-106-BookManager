//
//  EditView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct AddEditView: View {
    
    @Binding var book: Book
    @State var workingBook: Book
    @Environment(\.dismiss) var dismiss
    @State private var navigationTitle: String
    @State private var cover: UIImage? = nil
    
    private let modelContext: ModelContext

    init(book: Binding<Book>){
        self._book = book
        _workingBook = .init(initialValue: book.wrappedValue)
        self._navigationTitle = State(initialValue: book.wrappedValue.title.isEmpty ? "Add Book" : "Edit Book")
        if(book.imageData != nil){
            cover = UIImage(data: book.wrappedValue.imageData!)
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
                        TextEditor(text: $workingBook.description)
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
                            if (cover != nil){
                                var newImage = UploadedImage(
                                                imageName:"image for \(workingBook.title)",
                                                imageData: cover.jpegData(compressionQuality: 0.8))
                                do {
                                    modelContext.insert(newImage)
                                    try modelContext.save()
                                } catch {
                                    print("Failed to save image: \(error)")
                                }
                                workingBook.image
                            }
                            
                            
                            //Save the view
                            book = workingBook
                            dismiss()
                        }
                        .disabled(workingBook.title.isEmpty)
                    }
                }
        }
    }
}
