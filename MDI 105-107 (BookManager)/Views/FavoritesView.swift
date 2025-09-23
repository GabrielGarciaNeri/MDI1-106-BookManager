//
//  Untitled.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct FavoritesView: View {    //Not showing at the bottom of the page
    
    @Binding var books: [Book]
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    private var favoriteBooks: [Binding<Book>] {
        $books.filter{$0.wrappedValue.isFavorite}
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: gridLayout){
                    ForEach(favoriteBooks, id: \.self.id){ book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            SquareCardView(book: book)
                        }
                    }
                }
            }
        }
    }
    
    
}
