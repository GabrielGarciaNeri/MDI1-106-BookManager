//
//  Untitled.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    
    @Query var books:[PersistentBook]
    @State var isFilteringSheetPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    
    private var favoriteBooks: [PersistentBook] {
        filterFavoriteBooks(books: books, selectedGenre: selectedGenre, selectedStatus: selectedStatus)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if (selectedGenre != nil){
                    Text("Genre filter: \(selectedGenre!.rawValue)")
                }
                if (selectedStatus != nil){
                    Text("Status filter: \(selectedStatus!.rawValue)")
                }
                
                LazyVGrid(columns: gridLayout){
                    ForEach(favoriteBooks, id: \.self.id){ book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            SquareCardView(book: book)
                        }
                    }
                }
            }
            .navigationTitle("My Favorites")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {isFilteringSheetPresented = true}){
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                    .accessibilityLabel("Open filter options")
                }
            }
            .sheet(isPresented: $isFilteringSheetPresented){
                FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus )
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
    return books.filter{
            (isNegative! ? !$0.isFavorite : $0.isFavorite )
            && (selectedGenre == nil || $0.genre == selectedGenre )
            && (selectedStatus == nil || $0.status == selectedStatus)
        }
    }
