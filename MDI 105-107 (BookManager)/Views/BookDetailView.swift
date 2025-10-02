//
//  BookDetailView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct BookDetailView: View {

    let book: PersistentBook
    @State private var showEditView = false
    @Environment(\.modelContext) private var modelContext   // <-- needed to save favorite toggle

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray.opacity(0.1), .gray.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(
                            uiImage: {
                                if let data = book.imageData, let ui = UIImage(data: data) {
                                    return ui
                                } else {
                                    return UIImage(resource: .defaultBook)
                                }
                            }()
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding()

                        VStack {
                            Text(book.title)
                                .font(.system(size: 36, weight: .bold, design: .serif))
                                .multilineTextAlignment(.center)

                            if !book.author.isEmpty {
                                Text("by \(book.author)")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }

                    HStack {
                        if book.genre != .unknown {
                            CustomCapsule(text: book.genre.rawValue)
                        }
                        if book.status != .unknown {
                            CustomCapsule(text: book.status.rawValue, color: .secondary)
                        }
                        Spacer()
                    }

                    if !book.summary.isEmpty {
                        Text(book.summary)
                    }

                    if book.rating == 0 {
                        Text("No rating yet")
                    } else {
                        Text("Rating: \(book.rating) \(book.rating == 1 ? "star" : "stars")")
                    }

                    if !book.review.isEmpty {
                        Text(book.review)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Favorite toggle
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    book.isFavorite.toggle()
                    try? modelContext.save()
                } label: {
                    Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(book.isFavorite ? .red : .primary)
                }
                .accessibilityLabel(book.isFavorite ? "Remove from favorites" : "Add to favorites")
            }

            // Edit button
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") { showEditView = true }
            }
        }
        .sheet(isPresented: $showEditView) {
            AddEditView(book: book)
        }
    }
}


