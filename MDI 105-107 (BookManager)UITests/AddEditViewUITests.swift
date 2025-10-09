

import XCTest

final class AddEditViewUITests: XCTestCase {
    
    func testAddBookWorks() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Arrange: initial count
        let collection = app.collectionViews.firstMatch
        XCTAssertTrue(collection.waitForExistence(timeout: 5), "Main collection view did not appear")
        let beforeAddingBookCount = collection.cells.count
        
        // Act: tap Add and fill the form
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 2), "Add button not found")
        addButton.tap()
        
        let newBookTitle = "New book \(beforeAddingBookCount)"
        let titleField = app.textFields["Title of the book"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2), "Title text field not found")
        
        // Save should be disabled at first
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 2), "Save button not found")
        XCTAssertFalse(saveButton.isEnabled, "Save button should be disabled before entering title")
        
        titleField.tap()
        titleField.typeText(newBookTitle)
        
        saveButton.tap()
        
        // Assert: count increased by one and new cell visible
        XCTAssertTrue(collection.waitForExistence(timeout: 3))
        let afterAddingBookCount = collection.cells.count
        XCTAssertEqual(afterAddingBookCount, beforeAddingBookCount + 1)
        
        let lastCell = collection.cells.element(boundBy: beforeAddingBookCount)
        XCTAssertTrue(lastCell.staticTexts[newBookTitle].exists, "Newly added book title not visible in last cell")
    }
}
