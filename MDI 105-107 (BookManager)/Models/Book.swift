//
//  Book.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import Foundation
import SwiftData

struct Book: Identifiable {
    var id = UUID()
    var title: String
    //var image: String = "defaultBook"
    var imageData: Data?
    var description: String = "No description yet"
    var author: String = "Author"
    var rating: Int = 0
    var review: String = "No reviews yet"
    var status: ReadingStatus = .unknown
    var genre: Genre = .unknown
    var isFavorite: Bool = false
}


