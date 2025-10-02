//
//  FavoritesView.test.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/30/25.
//

import Testing
@testable import MDI_105_107__BookManager_

@MainActor @Suite("Favorite View tests")
struct FavoriteViewTests {
    
    @Test("Filter function works correctly")
    func filterFunction() {
        // Arrange
        let books = [
            PersistentBook(title:"Book1", isFavorite: true),
            PersistentBook(title:"Book2", isFavorite: false),
            PersistentBook(title:"Book3")
        ]
        
        // Act
        let favoriteBooks = filterFavoriteBooks(books: books, selectedGenre: nil, selectedStatus: nil)
        
        #expect(favoriteBooks.count == 1)
        #expect(favoriteBooks[0].title == "Book1")
    }
}
