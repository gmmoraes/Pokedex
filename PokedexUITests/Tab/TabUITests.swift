//
//  TabUITests.swift
//  PokedexUITests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import XCTest

class TabUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testChangeTab() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Favourites"].tap()
    }
    
    func testGoToDetail() throws {
        
        let app = XCUIApplication()
        app.tables.children(matching: .staticText)["bulbasaur"].children(matching: .staticText)["bulbasaur"].tap()
        
        let backButton = app.navigationBars["Pokedex.PokemonInformationView"].buttons["Back"]
        backButton.tap()
        app.tabBars["Tab Bar"].buttons["Favourites"].tap()
        app.collectionViews.staticTexts["bulbasaur"].otherElements.containing(.staticText, identifier:"Bulbasaur").element.tap()
        backButton.tap()
                
    }

    func testGoToDetailAfterScrollInList() throws {
        
        
        let tablesQuery = XCUIApplication().tables
        let table = tablesQuery.element(boundBy: 0)
        let ratataCell = table.children(matching: .staticText)["rattata"]
        table.scrollToElement(element: ratataCell, limitScrolls: 5)
        ratataCell.tap()
    }
}
