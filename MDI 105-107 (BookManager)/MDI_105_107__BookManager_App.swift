//
//  MDI_105_107__BookManager_App.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/11/25.
//

import SwiftUI
import SwiftData

@main
struct MDI_105_107__BookManager_App: App {
    let modelContainer: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
        
    }
    init() {
        do {
            modelContainer = try ModelContainer(for:UploadedImage.self, PersistentBook.self)
        } catch {
            fatalError("Failed to load model container")
        }
    }
}
