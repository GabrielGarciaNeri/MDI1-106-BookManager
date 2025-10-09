//
//  AddEditViewModel.test.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 10/7/25.
//

import Testing
import SwiftData
@testable import MDI_105_107__BookManager_

@MainActor
struct AddEditViewModel_test {
    @Test("ViewModel initializes correctly for a new book")
    func testNewBookInitialization() throws {
        //Phase 1: Arrange
        let container = try ModelContainer(for: PersistentBook.self, configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        
        //Phaser 2: Act
        let viewModel = AddEditViewModel(modelContext: modelContext)
        
        //Phase 3: Assert
        #expect(viewModel.title == "")
        #expect(viewModel.author == "")
        //every other field asssettions
        #expect (viewModel.navigationTitle == "Add Book")
        #expect (viewModel.isSaveButtonDisabled)
    }
    
    @Test("ViewModel initializes correctly for an existing book")
    func testExistingBookInitialization() throws {
        //Phase 1: Arrange
        let container = try ModelContainer(for: PersistentBook.self, configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        let book = Book.init(title: "1984", author: "George Orwell")
        
        
        //Phase 2: act
        let viewModel = AddEditViewModel(book: book, modelContext: modelContext)
        
        //Phase 3: assert
        #expect(viewModel.title == "1984")
        #expect(viewModel.author == "George Orwell")
        //every other field asssettions
        #expect (viewModel.navigationTitle == "Edit Book")
        #expect (viewModel.isSaveButtonDisabled)
        
        viewModel.title = " \n"
        #expect (viewModel.isSaveButtonDisabled)
        
        viewModel.title = "A New Book Title"
        #expect (!viewModel.isSaveButtonDisabled)
    }
    
    @Test("ViewModel adds a new book correctly")
    func testAddNewBook() throws {
        //Phase 1: Arrange
        
        //Phase 2: act
        
        //Phase 3: assert
    }
    
    @Test("ViewModel updates an existing book correctly")
    func testUpdateExistingBook() throws {
        //Phase 1: Arrange
        
        //Phase 2: act
        
        //Phase 3: assert
    }
}
