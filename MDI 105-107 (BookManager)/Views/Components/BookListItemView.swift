//
//  BookListItem.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookListItemView: View {
    let book: PersistentBook
    var compact: Bool = false   // <-- allows tighter row styling from Settings

    var body: some View {
        HStack(spacing: compact ? 8 : 12) {
            ZStack(alignment: .topTrailing) {
                Image(
                    uiImage: (book.imageData != nil
                              ? UIImage(data: book.imageData!)!
                              : UIImage(resource: .defaultBook))
                )
                .resizable()
                .scaledToFill()
                .frame(width: compact ? 44 : 50, height: compact ? 44 : 50)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))

                if book.isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(4)
                        .background(.thinMaterial, in: Circle())
                        .offset(x: 4, y: -4)
                }
            }

            VStack(alignment: .leading, spacing: compact ? 0 : 4) {
                Text(book.title)
                    .font(compact ? .subheadline : .body)
                    .lineLimit(2)
                    .padding(.vertical, compact ? 2 : 8)

                Text(book.summary)
                    .font(.system(size: compact ? 10 : 12))
                    .foregroundColor(.secondary)
                    .lineLimit(compact ? 1 : 2)
                    .padding(compact ? 2 : 4)
            }
        }
        .contentShape(Rectangle())
        .padding(.vertical, compact ? 2 : 6)
    }
}
