//
//  Api.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import Foundation

func getBooks() -> [Book] {
    return [
        
            Book(
                title:"The Fellowship of the Ring",
               // image:"lotr_fellowship",
                description:"The first book in the trilogy.",
                author:"J.R.R. Tolkien",
                
            ),
            Book(
                title:"The Two Towers",
              //  image:"lotr_towers",
                description:"The second book in the trilogy",
                author:"J.R.R. Tolkien",
            ),
            Book(
                title:"The Return of The King",
              //  image:"lotr_king",
                description:"The third and last book in the trilogy",
                author:"J.R.R. Tolkien",
                isFavorite: true,
            ),
            Book(
                title: "Empty book",
                isFavorite: true,
                )

        
    ]
}
