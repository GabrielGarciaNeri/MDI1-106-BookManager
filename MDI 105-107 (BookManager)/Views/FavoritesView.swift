//
//  Untitled.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) private var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @Query private var books: [PersistentBook]

    @State private var isFilteringSheetPresented = false
    @State private var selectedGenre: Genre? = nil
    @State private var selectedStatus: ReadingStatus? = nil

    private var favorites: [PersistentBook] {
        filterFavoriteBooks(
            books: books,
            selectedGenre: selectedGenre,
            selectedStatus: selectedStatus
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // Use the available width to compute equal square cells
                GeometryReader { geo in
                    let columnsCount = max(1, gridColumns)
                    let gridSpacing: CGFloat = 16
                    let horizontalPadding: CGFloat = 16
                    let available = geo.size.width
                        - (horizontalPadding * 2)
                        - (gridSpacing * CGFloat(columnsCount - 1))
                    let side = floor(available / CGFloat(columnsCount))

                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: columnsCount),
                        spacing: gridSpacing
                    ) {
                        ForEach(favorites) { book in
                            NavigationLink {
                                BookDetailView(book: book)
                            } label: {
                                // Force each card to the same square size
                                SquareCardView(book: book)
                                    .frame(width: side, height: side)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 8)
                }
                .frame(minHeight: 0) // keep GeometryReader from grabbing extra height
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Favorite Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilteringSheetPresented = true
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $isFilteringSheetPresented) {
                NavigationStack {
                    FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
                        .navigationTitle("Filter Options")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Clear") {
                                    selectedGenre = nil
                                    selectedStatus = nil
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Apply") { isFilteringSheetPresented = false }
                                    .bold()
                            }
                        }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}


func filterFavoriteBooks(
    books: [PersistentBook],
    selectedGenre: Genre?,
    selectedStatus: ReadingStatus?,
    isNegative: Bool? = false
) -> [PersistentBook] {
    books.filter {
        (isNegative! ? !$0.isFavorite : $0.isFavorite)
        && (selectedGenre == nil || $0.genre == selectedGenre)
        && (selectedStatus == nil || $0.status == selectedStatus)
    }
}
