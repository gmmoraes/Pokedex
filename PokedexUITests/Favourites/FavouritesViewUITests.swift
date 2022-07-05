//
//  FavouritesViewUITests.swift
//  PokedexUITests
//
//  Created by Gabriel Moraes on 30/06/22.
//

import XCTest

class FavouritesViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testFavoriteBulbasaur() throws {
        
        let app = XCUIApplication()
        let bulbasaurStaticText = app.tables.children(matching: .staticText)["bulbasaur"].children(matching: .staticText)["bulbasaur"]
        bulbasaurStaticText.tap()
        
        let pokedexPokemoninformationviewNavigationBar = app.navigationBars["Pokedex.PokemonInformationView"]
        pokedexPokemoninformationviewNavigationBar.buttons["love"].tap()
        
        let backButton = pokedexPokemoninformationviewNavigationBar.buttons["Back"]
        backButton.tap()

        app.tabBars["Tab Bar"].buttons["Favourites"].tap()
        app.collectionViews.staticTexts["bulbasaur"].otherElements.containing(.staticText, identifier:"Bulbasaur").element.tap()
        
        XCTAssertTrue(app.collectionViews.staticTexts["bulbasaur"].exists)
    }
    
    func testUnFavourite() throws {
        
        // Favoritar charmander
        // Voltar para lista
        // Desfavoritar charmander
        // Garantir que o charmandar não aparece na lista de favoritos
        
        let app = XCUIApplication()
        let pokedexPokemoninformationviewNavigationBar = app.navigationBars["Pokedex.PokemonInformationView"]
        let loveButton = pokedexPokemoninformationviewNavigationBar.buttons["love"]
        loveButton.tap()
        
        let backButton = pokedexPokemoninformationviewNavigationBar.buttons["Back"]
        backButton.tap()
        app.tabBars["Tab Bar"].buttons["Favourites"].tap()
        app.tabBars["Tab Bar"].buttons["List"].tap()
        
        app.tables.children(matching: .staticText)["charmander"].children(matching: .staticText)["charmander"].tap()
        loveButton.tap()
        backButton.tap()
        app.tabBars["Tab Bar"].buttons["Favourites"].tap()
        
        XCTAssertFalse(app.collectionViews.staticTexts["charmander"].exists)
                
    }
    

}
