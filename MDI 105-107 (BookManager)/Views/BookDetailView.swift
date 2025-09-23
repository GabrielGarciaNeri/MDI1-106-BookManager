//
//  BookDetailView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookDetailView: View {
    
    @Binding var book: Book
    @State private var showEditView: Bool = false
    
    var body: some View {
        NavigationStack{
            Text("Book Detail:")
                .foregroundStyle(.secondary)
                .padding()
            
            ScrollView{
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
                    
                    if (book.description != "") {
                            Text(book.description)
                    }
                    HStack{
                        Spacer()
                        Toggle(isOn: $book.isFavorite){
                            Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                .renderingMode(.original)
                        }
                        .toggleStyle(.button)
                        .font(.title)
                        .accessibilityLabel(book.isFavorite ? "Remove from favorites" : "Add to favorites")
                    }
                    if (book.rating == 0){
                        Text("No rating yet")
                    }else {
                        Text("Rating: \(book.rating) \(book.rating == 1 ? "star" : "stars")")
                    }
                    Text(book.review)
                }
                .padding()
                
                
            }
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline) //lines it up with the blue button
        .navigationBarItems(trailing: Button("Edit"){
            showEditView.toggle()
        })
        .sheet(isPresented: $showEditView, content: {
            EditView(book: $book)
        })
        Spacer() //pushh everything up
    }
}



