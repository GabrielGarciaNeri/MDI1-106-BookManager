//
//  BookListView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Query var books: [PersistentBook]

    // Add / Filter state
    @State private var showAddView = false
    @State private var isFilteringSheetPresented = false
    @State private var listSelectedGenre: Genre? = nil
    @State private var listSelectedStatus: ReadingStatus? = nil
    
    @Environment(\.modelContext) private var modelContext

    // Settings used by the list
    @AppStorage(SETTINGS_LIST_COMPACT_ROWS_KEY)
    private var listCompactRows: Bool = SETTINGS_LIST_COMPACT_ROWS_DEFAULT

    @AppStorage(SETTINGS_LIST_SORT_KEY)
    private var listSort: ListSort = SETTINGS_LIST_SORT_DEFAULT

    // Filter + sort the books shown in the list
    private var filteredAndSortedBooks: [PersistentBook] {
        var output = books
            .filter {
                (listSelectedGenre == nil  || $0.genre  == listSelectedGenre) &&
                (listSelectedStatus == nil || $0.status == listSelectedStatus)
            }

        switch listSort {
        case .title:
            output.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .author:
            output.sort { $0.author.localizedCaseInsensitiveCompare($1.author) == .orderedAscending }
        case .rating:
            output.sort { $0.rating > $1.rating }
        }
        return output
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredAndSortedBooks) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        BookListItemView(book: book, compact: listCompactRows)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            book.isFavorite.toggle()
                            try? modelContext.save()
                        } label: {
                            Label(book.isFavorite ? "Unfavorite" : "Favorite",
                                  systemImage: book.isFavorite ? "heart.slash" : "heart.fill")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("BookManager")
            .toolbar {
                // Filter button (top-right)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilteringSheetPresented = true
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                // Add button (top-right)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            // Add sheet
            .sheet(isPresented: $showAddView) {
                AddEditView()
            }
            // Filter sheet
            .sheet(isPresented: $isFilteringSheetPresented) {
                NavigationStack {
                    FilterView(
                        selectedGenre: $listSelectedGenre,
                        selectedStatus: $listSelectedStatus
                    )
                    .navigationTitle("Filter Options")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Clear") {
                                listSelectedGenre = nil
                                listSelectedStatus = nil
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Apply") {
                                isFilteringSheetPresented = false
                            }
                            .bold()
                        }
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}
