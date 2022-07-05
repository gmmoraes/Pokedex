//
//  PokemonTypeCollectionViewCellTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonTypeCollectionViewCellTests: XCTestCase {

    var sut: PokemonTypeCollectionViewCell?
    let grassType = TypesModel(name: "grass", url: "")

    override func setUpWithError() throws {
        sut = PokemonTypeCollectionViewCell()
        sut?.datasource = grassType
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
        XCTAssertTrue(sut.accessibilityLabel?.lowercased() == grassType.name.lowercased())
        XCTAssertTrue(sut.accessibilityTraits == .staticText)
        XCTAssertTrue(sut.shouldGroupAccessibilityChildren)

        
    }

}

