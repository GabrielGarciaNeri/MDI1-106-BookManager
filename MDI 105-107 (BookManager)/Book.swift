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
    var image: String
    var description: String
    var author: String
}


