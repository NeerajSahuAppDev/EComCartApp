//
//  ECC_OrderSummaryViewController.swift
//  EComCartUITests
//
//  Created by mytsl01831 on 30/04/22.
//

import XCTest

class EComCartOrderSummaryUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingEntry() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Line 1
        let app = XCUIApplication()
        app.launch()
 
        
        let textView = app.textViews["Order_Summary_TextView"]

        textView.title = "add:123"
        XCTAssert(textView.title == "add:123")
    }

    
    
}
