//
//  FavouritesCollectionViewTest.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class FavouritesCollectionViewTest: XCTestCase {

    var sut: FavouritesCollectionViewCell?
    let pokemonName = "bulbasaur"

    override func setUpWithError() throws {
        let model = createModel()
        let theme = ListCollectionTheme(masksToBounds: false)
        sut = FavouritesCollectionViewCell()
        sut?.updateData(model: model, theme: theme)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    private func createModel() -> PokemonInformationModel {
        let typesModel = TypesModel(name: "", url: "")
        let types = TypeElement(slot: 0, type: typesModel)
        let model = PokemonInformationModel(baseExperience: 0, height: 1, id: 1, name: pokemonName, typeElements: [types], sprites: SpritesModel(other: OtherSpritesModel(officialArtwork: OfficialArtworkModel(url: ""))), weight: 1, isFavourited: true)
        return model
    }


    func testAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(sut.isAccessibilityElement)
        XCTAssertTrue(sut.accessibilityLabel?.lowercased() == pokemonName.lowercased())
        XCTAssertTrue(sut.accessibilityTraits == .staticText)
        XCTAssertTrue(sut.shouldGroupAccessibilityChildren)

        
    }
}
