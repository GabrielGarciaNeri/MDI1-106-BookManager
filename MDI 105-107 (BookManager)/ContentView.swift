//
//  ContentView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    let books = getBooks()
    
    var body: some View{
        NavigationStack{
            List(books, id: \.self.id){ bookItem in
            
                NavigationLink(destination: BookDetailView(book: bookItem)){
                    BookListItem(book: bookItem)
                }
            }
            .navigationTitle("BookManager")
        }
    }
    
}

#Preview {
    ContentView()
}
