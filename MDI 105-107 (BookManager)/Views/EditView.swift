//
//  EditView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct EditView: View {
    
    @Binding var book: Book
    @State var workingBook: Book
    @Environment(\.dismiss) var dismiss

    init(book: Binding<Book>){
        self._book = book
        _workingBook = .init(initialValue: book.wrappedValue)
    }
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                ScrollView{
                    Form{
                        Section(header: Text("Book Details")) {
                            TextField("Title of the book", text: $workingBook.title)
                            TextField("Author", text: $workingBook.author)
                            TextEditor(text: $workingBook.description)
                                .frame(height: 100)
                            
                        }
                        Section(header: Text("My review")){

                            StarRatingView(rating: $workingBook.rating)
                            TextEditor(text: $workingBook.review)
                                .frame(height: 150)
                        }
                    }
                    
                }
            }.navigationTitle("Edit Book")
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save"){
                            //Save the view
                            book = workingBook
                            dismiss()
                        }
                    }
                }
        }
    }
}
