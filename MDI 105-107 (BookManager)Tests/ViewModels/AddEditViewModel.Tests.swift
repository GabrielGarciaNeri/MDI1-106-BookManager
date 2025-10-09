


import Testing
import SwiftData
@testable import MDI_105_107__BookManager_

@MainActor
struct AddEditViewModelTests {
    
    @Test("ViewModel initializes correctly for a new book")
    func testNewBookInitialization() throws {
        // phase 1: Arrange
        let container = try ModelContainer(
            for: PersistentBook.self,
            configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        
        // phase 2: Act
        let viewModel = AddEditViewModel(modelContext: modelContext)
        
        // phase 3: Assert
        #expect(viewModel.title == "")
        #expect(viewModel.author == "")
        #expect(viewModel.summary == "")
        #expect(viewModel.rating == 0)
        #expect(viewModel.review == "")
        #expect(viewModel.status == .unknown)
        #expect(viewModel.genre == .unknown)
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.navigationTitle == "Add Book")
        #expect(viewModel.isSaveButtonDisabled)
    }
    
    @Test("ViewModel initializes correctly for an existing book")
    func testExistingBookInitialization() throws {
        // phase 1: Arrange
        let container = try ModelContainer(
            for: PersistentBook.self,
            configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        let book = PersistentBook(title: "Test Book", summary: "S", author: "Test Author", rating: 3, review: "R", status: .reading, genre: .fantasy, isFavorite: true)
        
        // phase 2: Act
        let viewModel = AddEditViewModel(book: book, modelContext: modelContext)
        
        // phase 3: Assert
        #expect(viewModel.title == "Test Book")
        #expect(viewModel.author == "Test Author")
        #expect(viewModel.navigationTitle == "Edit Book")
        #expect(viewModel.isSaveButtonDisabled)
        
        viewModel.title = " \n"
        #expect(viewModel.isSaveButtonDisabled)
        
        viewModel.title = "Test Book"
        #expect(viewModel.isSaveButtonDisabled)
        
        viewModel.title = "Test Book 2"
        #expect(!viewModel.isSaveButtonDisabled)
    }
    
    @Test("ViewModel creates a new book correctly")
    func testCreateNewBook() throws {
        // Placeholder for save() behavior test
    }
    
    @Test("ViewModel updates an existing book correctly")
    func testUpdateExistingBook() throws {
        // Placeholder for save() behavior test
    }
}
