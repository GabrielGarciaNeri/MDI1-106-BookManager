//
//  SquareCardView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct SquareCardView: View {
    var book: PersistentBook
    
    var body: some View {
        VStack(alignment: .leading){
            Text(book.title)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding()
                .background(LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            Spacer()
            Text("\(book.author)")
                .frame(maxWidth: .infinity)
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(4)
                .background(LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            
     
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(
                uiImage: (book.imageData != nil ?
                            UIImage(data:book.imageData!) :UIImage(resource: .defaultBook))!)
            .resizable()
            .scaledToFit().opacity(0.9)
        )
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
