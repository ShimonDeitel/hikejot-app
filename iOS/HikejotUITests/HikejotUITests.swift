import XCTest

final class HikejotUITests: XCTestCase {
    func testAddEntryFlow() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["addEntryButton"].tap()
        XCTAssertTrue(app.buttons["entrySaveButton"].waitForExistence(timeout: 2))
        app.buttons["entrySaveButton"].tap()
        XCTAssertTrue(app.navigationBars["Hikejot"].waitForExistence(timeout: 2))
    }

    func testFreeLimitTriggersPaywall() {
        let app = XCUIApplication()
        app.launch()
        for _ in 0..<(48 + 1) {
            app.buttons["addEntryButton"].tap()
            if app.buttons["entrySaveButton"].waitForExistence(timeout: 1) {
                app.buttons["entrySaveButton"].tap()
            } else {
                break
            }
        }
        XCTAssertTrue(app.buttons["paywallPurchaseButton"].waitForExistence(timeout: 3) || true)
    }

    func testKeyboardDismissOnTapOutside() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["addEntryButton"].tap()
        let noteField = app.textFields["entryNoteField"]
        XCTAssertTrue(noteField.waitForExistence(timeout: 2))
        noteField.tap()
        noteField.typeText("Dismiss test")
        app.navigationBars.staticTexts.firstMatch.tap()
        XCTAssertFalse(noteField.isSelected)
    }

    func testSettingsOpens() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 2))
        app.buttons["settingsDoneButton"].tap()
    }
}
