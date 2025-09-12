//
//  BookDetailView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookDetailView: View {
    
    var book: Book
    
    var body: some View {
        NavigationStack{
            Text("Book Detail:")
                .foregroundStyle(.secondary)
                .padding()
            VStack{
                HStack{
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    Text(book.title)
                        .font(.title.bold())
                }
                .padding()
                Text("The first book in \(book.author)'s high-fantasy.")
                    .padding()
            }
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline) //lines it up with the blue button
        Spacer() //pushh everything up
    }
}



