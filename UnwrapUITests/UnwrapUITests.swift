//
//  UnwrapUITests.swift
//  Unwrap
//
//  Created by Paul Hudson on 09/08/2018.
//  Copyright © 2018 Hacking with Swift.
//

import XCTest

class UnwrapUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHomeViewControllerExists() {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars

        tabBarsQuery.buttons["Home"].tap()

        XCTAssertTrue(app.tables.otherElements["Ring progress"].exists)
        XCTAssertTrue(app.tables.cells["Rank"].exists)
        XCTAssertTrue(app.tables.cells["Points"].exists)
        XCTAssertTrue(app.tables.cells["Stat"].exists)
        XCTAssertTrue(app.tables.cells["Streak Reminder"].exists)
        XCTAssertTrue(app.tables.cells["Badges"].exists)
    }

    //Check that trying to share score displays the ActivityView on the HomeViewController
    func testShareScoreShows() {
        let app = XCUIApplication()

        app.tables.cells["Stat"].staticTexts["Share Score"].tap()

        //Delay ActivityViewController to verify the right buttons exist
        let predicate = NSPredicate(format: "exists == 1")
        let query = app.collectionViews.cells.collectionViews.containing(.button, identifier: "More").element

        expectation(for: predicate, evaluatedWith: query, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)
    }

    //Check that tapping Help on the HomeViewController and then Credit show the correct controllers
    func testHelpAndCreditShow() {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars

        tabBarsQuery.buttons["Home"].tap()

        XCTAssertTrue(app.buttons["Help"].exists)

        app.buttons["Help"].tap()

        XCTAssertTrue(app.navigationBars["Help"].exists)
        XCTAssertTrue(app.buttons["Credits"].exists)

        app.buttons["Credits"].tap()

        XCTAssert(app.navigationBars["Credits"].exists)
    }

    //Check that Learn activity opens and "Glossary" and "Learn" buttons work
    func testLearnActivity() {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars

        XCTAssertTrue(!app.buttons["Glossary"].exists)

        tabBarsQuery.buttons["Learn"].tap()

        XCTAssertTrue(app.buttons["Glossary"].exists)

        app.buttons["Glossary"].tap()

        XCTAssertTrue(app.buttons["Learn"].exists)

        app.buttons["Learn"].firstMatch.tap()

        XCTAssertTrue(app.buttons["Glossary"].exists)
    }

    //Check that practice activity and alerts are working
    func testPracticeActivity() {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars

        tabBarsQuery.buttons["Practice"].tap()

        print(app.debugDescription)

        app.staticTexts["Free Coding"].tap()

        XCTAssert(app.alerts["Activity Locked"].exists)

        app.alerts["Activity Locked"].buttons["OK"].tap()

        XCTAssert(!app.alerts["Activity Locked"].exists)
    }

    //Check that Next button works
    func testLearnNext() {
        let app = XCUIApplication()
        let tabBarsQuery = XCUIApplication().tabBars

        tabBarsQuery.buttons["Learn"].tap()

        XCTAssert(app.staticTexts["Simple Types"].exists)
        XCTAssert(app.staticTexts["Variables"].exists)

        app.staticTexts["Variables"].tap()

        XCTAssert(app.navigationBars.firstMatch.exists)
        XCTAssert(app.navigationBars.firstMatch.otherElements["Variables"].exists)

        app.navigationBars.firstMatch.otherElements["Variables"].tap()

        XCTAssert(app.buttons["Next"].exists)
        XCTAssert(!app.staticTexts["Variables"].exists)
        XCTAssert(!app.buttons["OK"].exists)

        app.buttons["Next"].tap()

        XCTAssert(app.staticTexts["Variables"].exists)
        XCTAssert(app.buttons["OK"].exists)

        app.buttons["OK"].tap()
        //Todo Check hint and skip
//        XCTAssert(app.buttons["Hint"].exists)
        print(app.debugDescription)
    }

    func testBuySwiftBooksLink() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars

        tabBarsQuery.buttons["News"].tap()

        XCTAssert(app.buttons["Buy Swift Books"].exists)

        app.buttons["Buy Swift Books"].tap()

        XCTAssert(app.buttons["Done"].exists)

        app.buttons["Done"].tap()

        XCTAssert(app.navigationBars["News"].exists)
    }

}
