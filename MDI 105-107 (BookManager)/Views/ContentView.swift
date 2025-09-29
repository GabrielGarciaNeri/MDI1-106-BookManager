//
//  ContentView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    @State var books = getBooks()
    
    @AppStorage(SETTINGS_THEME_KEY) var theme: Theme = .light
    @AppStorage(SETTINGS_ACCENT_COLOR_KEY) var accentColor: Color = SETTINGS_ACCENT_COLOR_DEFAULT_VALUE
    
    var colorScheme: ColorScheme? {
        switch(theme){
        case Theme.light:
            return .light
        case Theme.dark:
            return .dark
        case Theme.system:
            return nil
        }
    }
    
    var body: some View{
        TabView{
            BookListView(books: $books)
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill")
                }
            
            FavoritesView(books: $books)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            ImageViewer()
                .tabItem {
                    Label("Image Viewer", systemImage: "image.fill")
                }
        }
        .tint(accentColor)
        .preferredColorScheme(colorScheme)
    }
    
}

#Preview {
    ContentView()
}
