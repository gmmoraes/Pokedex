//
//  PokemonListViewTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonListViewTests: XCTestCase {
    
    var mainView: PokemonListView?

    override func setUpWithError() throws {
        let serviceDummy = ServiceableDummy()
        mainView = PokemonListView(viewModel: PokemonListViewModel(service: serviceDummy))
    }

    override func tearDownWithError() throws {
        mainView = nil
    }

    func testTitleLabel() throws {
        guard let mainView = mainView else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(mainView.titleLbl.isAccessibilityElement)
        XCTAssertTrue(mainView.titleLbl.accessibilityLabel == PokemonListConstants.titleText)
        XCTAssertTrue(mainView.titleLbl.accessibilityTraits == .header)
        
    }
    
    func testPokeballImageView() throws {
        guard let mainView = mainView else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(mainView.pokeballImageView.isAccessibilityElement)
        
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
