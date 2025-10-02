//
//  Genre.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

enum Genre: String, CaseIterable, Hashable, Codable {
    case classic = "Classic"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case romance = "Romance"
    case horror = "Horror"
    case mystery = "Mystery"
    //base case
    case unknown = "Unknown"
}
