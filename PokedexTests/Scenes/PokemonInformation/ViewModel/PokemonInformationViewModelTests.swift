//
//  PokemonInformationViewModelTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonInformationViewModelTests: XCTestCase {

    let listModelDummy = PokemonListModel(name: "", urlStr: "https://pokeapi.co/api/v2/pokemon/1/")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetData() throws {

        // Given

        let expectation = XCTestExpectation(description: "GetData")
        let service = ServiceableMock(fileName: "pokemonInformation", resultType: PokemonInformationModel.self)
        let sut = PokemonInformationViewModel(listModel: listModelDummy, service: service)
        
        // When

        sut.getData()  { result in
            switch result {
            case .success(let data):
                XCTAssert(data.name == "bulbasaur")
                XCTAssert(data.baseExperience == 64)
                XCTAssert(data.id == 1)
                XCTAssert(data.weight == 69)
                XCTAssert(data.typeElements.first?.type.name == "grass")
                XCTAssert(data.typeElements[1].type.name == "poison")
                XCTAssert(data.isFavourited == false)
                expectation.fulfill()
            default:
                XCTFail()
                break
            }
        }
    }

    func testToggleFavourite() throws {

        // Given

        let expectation = XCTestExpectation(description: "toggleFavourite")
        let service = ServiceableMock(fileName: "pokemonInformation", resultType: PokemonInformationModel.self)
        let sut = PokemonInformationViewModel(listModel: listModelDummy, service: service)
        
        // When

        sut.getData()  { result in
            switch result {
            case .success(let data):
                sut.model = data
                sut.toggleFavourite()
                sut.isFavourited = { isFavourited in
                    XCTAssertTrue(isFavourited)
                    expectation.fulfill()
                }
            default:
                XCTFail()
                break
            }
        }
    }


}
