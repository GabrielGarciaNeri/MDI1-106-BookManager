//
//  ImageViewer.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/27/25.
//

import SwiftUI
import SwiftData

struct ImageViewer: View {
    @Query private var books: [PersistentBook]

    // 3 columns on larger screens, 2 on compact
    private var columns: [GridItem] {
        [GridItem(.flexible(), spacing: 12),
         GridItem(.flexible(), spacing: 12),
         GridItem(.flexible(), spacing: 12)]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(books.filter { $0.imageData != nil }) { book in
                        if let data = book.imageData, let ui = UIImage(data: data) {
                            NavigationLink {
                                // Fullscreen-ish view
                                VStack {
                                    Spacer()
                                    Image(uiImage: ui)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                    Text(book.title)
                                        .font(.headline)
                                        .padding(.bottom, 12)
                                    Spacer()
                                }
                                .background(Color(.systemBackground))
                                .navigationTitle(book.title)
                                .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                Image(uiImage: ui)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 4, y: 2)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Image Viewer")
        }
    }
}
