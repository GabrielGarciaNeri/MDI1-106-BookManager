

import Testing
@testable import MDI_105_107__BookManager_

@MainActor @Suite("Persistent Book tests")
struct PersistentBookTests {
    
    @Test("Persistent Book initializer & mutation")
    func testPersistentBookInitializer() {
        // Arrange
        let bookTitle = "Test Title"
        let status = ReadingStatus.reading
        let author = "Test Author"
        let isFavorite = true
        
        // Act
        let book = PersistentBook(title: bookTitle)
        
        // Assert – initial defaults
        #expect(book.title == bookTitle)
        #expect(book.status == .unknown)
        #expect(book.author == "")
        #expect(book.isFavorite == false)
        #expect(book.getNameAndAuthor() == "Test Title by Unknown Author")
        
        // Act II – mutate existing instance
        book.status = status
        book.author = author
        book.isFavorite = isFavorite
        
        // Assert – mutated state
        #expect(book.status == .reading)
        #expect(book.author == "Test Author")
        #expect(book.isFavorite == true)
        #expect(book.getNameAndAuthor() == "Test Title by Test Author")
    }
}
