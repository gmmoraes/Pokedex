//
//  FavoritePokemonViewModelTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class FavoritePokemonViewModelTests: XCTestCase {
    
    var sut: FavoritePokemonViewModel?
    var coredatastack: TestCoreDataStack!
    var coredataManager: CoredataManager!

    override func setUpWithError() throws {
        coredatastack = TestCoreDataStack()
        coredataManager = CoredataManager(coredatastack: coredatastack)
        let models = mockModel(amount: 12)
        for model in models {
            coredataManager.savePokemon(model: model, image: nil)
        }
        sut = FavoritePokemonViewModel(coreDataManager: coredataManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        coredatastack = nil
        coredataManager = nil
    }
    
    private func mockModel(amount: Int) -> [PokemonInformationModel]{
        var models: [PokemonInformationModel] = []
        for i in 0...amount {
            let typesModel = TypesModel(name: "", url: "")
            let types = TypeElement(slot: i, type: typesModel)
            let model = PokemonInformationModel(baseExperience: 0, height: 1, id: i, name: "", typeElements: [types], sprites: SpritesModel(other: OtherSpritesModel(officialArtwork: OfficialArtworkModel(url: ""))), weight: 1, isFavourited: true)
            models.append(model)
        }
        
        return models
    }
    
    func testGetDataSuccess() throws {
        
        // Given
        let expectation = XCTestExpectation(description: "getData")
        guard let sut = sut else {
            XCTFail("Sut should not be nil")
            return
        }

        // When
        
        sut.getFavouritePokemon(limit: 2) { result in
            switch result {
            case .success(let data):
                XCTAssert(data.count > 0)
                expectation.fulfill()
            default:
                XCTFail()
                break
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testprefetchDataSuccess() throws {
        
        // Given
        let expectation = XCTestExpectation(description: "preFetchData")
        guard let sut = sut else {
            XCTFail("Sut should not be nil")
            return
        }

        // When

        sut.preFetchData(indexPath: IndexPath(row: 0, section: 0)) { result in
            switch result {
            case .success(let data):
                XCTAssert(data.count > 0)
                expectation.fulfill()
            default:
                XCTFail()
                break
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
    }

    func testShouldNotFetchWhenDifferenceLowerThan10() throws {
        
        // Given

        guard let sut = sut else {
            XCTFail("Sut should not be nil")
            return
        }
        sut.pokemonModels = mockModel(amount: 11)
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        
        XCTAssertFalse(sut.checkIfIndexPathIsValid(indexPath: indexPath))
        
    }


}
