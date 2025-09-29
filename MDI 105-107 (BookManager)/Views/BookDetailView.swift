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
                        if (book.author != ""){
                            Text("by \(book.author)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack{
                        if (book.genre != .unknown){
                            CustomCapsule(text:book.genre.rawValue)
                        }
                        if (book.status != .unknown){
                            CustomCapsule(text:book.status.rawValue, color: .secondary)
                        }
                        
                        Spacer()
                        FavoriteToggle(isFavorite: $book.isFavorite)
                    }
                                        
                    if (book.description != "") {
                            Text(book.description)
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
            AddEditView(book: $book)
        })
        Spacer() //pushh everything up
    }
}



