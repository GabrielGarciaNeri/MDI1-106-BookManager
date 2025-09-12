//
//  BookListItem.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookListItem: View {
    
    var book: Book
    var body: some View {
        HStack{
            Image(book.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(book.title)
                Text(book.description).font(.system(size: 12))
            }
        }
    }
    
}
