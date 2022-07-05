//
//  PokemonListViewCellTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonListViewCellTests: XCTestCase {

    var sut: PokemonListViewCell?
    let model = PokemonListModel(name: "bulbasaur", urlStr: "")

    override func setUpWithError() throws {
        sut = PokemonListViewCell()
        sut?.updateData(datasource: model)
    }

    override func tearDownWithError() throws {
        sut = nil
    }


    func testAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(sut.isAccessibilityElement)
        XCTAssertTrue(sut.accessibilityLabel?.lowercased() == model.name.lowercased())
        XCTAssertTrue(sut.accessibilityTraits == .staticText)
        XCTAssertTrue(sut.shouldGroupAccessibilityChildren)

        
    }
}
