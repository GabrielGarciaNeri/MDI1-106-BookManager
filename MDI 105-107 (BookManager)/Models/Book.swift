//
//  Book.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import Foundation

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var image: String = "book.fill"
    var description: String = "No description yet"
    var author: String = "Author"
    var rating: Int = 0
    var review: String = "No reviews yet"
    var isFavorite: Bool = false
}


