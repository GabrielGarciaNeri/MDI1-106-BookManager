//
//  ContentView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    @State var books = getBooks()
    
    var body: some View{
        TabView{
            BookListView(books: $books)
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill")
                }
            
            FavoritesView(books: $books)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        
    }
    
}

#Preview {
    ContentView()
}
