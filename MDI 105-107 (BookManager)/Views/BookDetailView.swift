//
//  BookDetailView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookDetailView: View {
    
    var book: PersistentBook
    @State private var showEditView: Bool = false
    
    var body: some View {
        ZStack{
           LinearGradient(
            gradient: Gradient(
                colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
            startPoint: .top,
            endPoint: .bottom
           )
           .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    HStack{

                        Image(
                            uiImage: (book.imageData != nil ?
                                UIImage(data: book.imageData!)
                                :UIImage(resource: .defaultBook))!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding()
                        VStack{
                            Text(book.title)
                                .font(.system(size: 36, weight: .bold, design: .serif))
                            if (book.author != ""){
                                Text("by \(book.author)")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
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
//                        FavoriteToggle(isFavorite: book.isFavorite)
                    }
                                        
                    if (book.summary != "") {
                            Text(book.summary)
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
            AddEditView(book: book)
        })
        Spacer() //pushh everything up
    }
}



