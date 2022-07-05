//
//  PokemonListViewModelTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldNotPreFetchDataWhenDifferenceLowerThan10() throws {
        
        // Given
        let expectation = XCTestExpectation(description: "Prefetch")
        let service = ServiceableDummy()
        let sut = PokemonListViewModel(service: service)
        let indexPath = IndexPath(row: 20, section: 0)
        
        // When
        
        sut.preFetchData(indexPath: indexPath) { result in
            switch result {
            case .success(let _):
                XCTFail()
            default:
                XCTAssert(sut.pokemonList.count == 0)
                expectation.fulfill()
                break
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testResponseShouldSuccess() throws {
        
        // Given
        let expectation = XCTestExpectation(description: "Fetch")
        let service = ServiceableMock(fileName: "pokemonlist", resultType: PokemonListResults.self)
        let sut = PokemonListViewModel(service: service)
        
        // When
        
        sut.fetchData() { result in
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
    
    func testResponseShouldFail() throws {

        // Given
        let expectation = XCTestExpectation(description: "Fetch")
        let service = ServiceableMock(fileName: "pokemonlistFail", resultType: PokemonListResults.self)
        let sut = PokemonListViewModel(service: service)
        
        // When
        
        sut.fetchData() { result in
            switch result {
            case .success(let data):
                XCTFail()
            default:
                XCTAssert(sut.pokemonList.count == 0)
                expectation.fulfill()
                break
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
