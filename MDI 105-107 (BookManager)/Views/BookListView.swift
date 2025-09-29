//
//  BookListView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct BookListView: View {
    @Binding var books: [Book]
    @State private var showAddView: Bool = false
    @State var newBook = Book(title:"")
    
    var body: some View {
        NavigationStack{
            List($books, id: \.self.id){ $bookItem in
            
                NavigationLink(destination: BookDetailView(book: $bookItem)){
                    BookListItemView(book: bookItem)
                }
            }
            .navigationTitle("BookManager")
            .navigationBarItems(trailing: Button("Add"){
                showAddView.toggle()
            })
            .sheet(
                isPresented: $showAddView,
                
            ){
                if !newBook.title.isEmpty{
                    books.append(newBook)
                }
                newBook = Book(title: "")
            } content: {
                    AddEditView(book: $newBook)
            }
        }
    }
}
