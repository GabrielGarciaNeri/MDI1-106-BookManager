//
//  SquareCardView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct SquareCardView: View {
    let book: PersistentBook

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image fills whatever square size the parent gives it
            Image(
                uiImage: (book.imageData != nil
                          ? UIImage(data: book.imageData!)!
                          : UIImage(resource: .defaultBook))
            )
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()

            // Bottom gradient for readability
            LinearGradient(
                colors: [.black.opacity(0.65), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 90)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

            // Title + rating on top of the gradient
            VStack(alignment: .leading, spacing: 6) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)
                    .shadow(radius: 2)

                HStack(spacing: 4) {
                    ForEach(0..<5, id: \.self) { idx in
                        Image(systemName: idx < book.rating ? "star.fill" : "star")
                            .font(.caption2)
                    }
                }
                .opacity(0.95)
            }
            .foregroundColor(.white)
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)

        // The grid sets a fixed square frame for perfect alignment.
    }
}
