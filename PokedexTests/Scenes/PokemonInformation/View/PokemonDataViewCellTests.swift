//
//  PokemonDataViewCellTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonDataViewCellTests: XCTestCase {

    var sut: PokemonDataViewCell?
    let model = PokemonTableDatasource(keyConstant: "Name", valueContants: "bulbasaur")

    override func setUpWithError() throws {
        sut = PokemonDataViewCell()
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
        XCTAssertTrue(sut.accessibilityLabel == String(format: "%@ : %@", model.keyConstant, model.valueContants))
        XCTAssertTrue(sut.accessibilityTraits == .staticText)
        XCTAssertTrue(sut.shouldGroupAccessibilityChildren)

        
    }
}
