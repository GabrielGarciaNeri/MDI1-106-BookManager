//
//  Untitled.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct FavoritesView: View {
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    
    @Binding var books: [Book]
    @State var isFilteringSheetPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    
    private var favoriteBooks: [Binding<Book>] {
        $books.filter{
            $0.wrappedValue.isFavorite
            && (selectedGenre == nil || $0.wrappedValue.genre == selectedGenre )
            && (selectedStatus == nil || $0.wrappedValue.status == selectedStatus)
            }
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
