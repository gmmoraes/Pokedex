//
//  PokemonInformationViewTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonInformationViewTests: XCTestCase {

    var sut: PokemonInformationView?
    var viewModel: PokemonInformationViewModel!
    let pokemonName = "bulbasaur"
    var coredatastack: TestCoreDataStack!
    var coredataManager: CoredataManager!

    override func setUpWithError() throws {
        let serviceDummy = ServiceableStub()
        let listModelStub = PokemonListModel(name: pokemonName, urlStr: "")
        coredatastack = TestCoreDataStack()
        coredataManager = CoredataManager(coredatastack: coredatastack)
        viewModel = PokemonInformationViewModel(listModel: listModelStub, service: serviceDummy, coreDataManager: coredataManager)
        sut = PokemonInformationView(viewModel: viewModel)
        sut?.bindView()
    }

    override func tearDownWithError() throws {
        sut = nil
        viewModel = nil
    }


    func testTitleLabelAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "GetData")
        
        DispatchQueue.main.async {
            XCTAssertTrue(sut.titleLbl.isAccessibilityElement)
            XCTAssertTrue(sut.titleLbl.accessibilityLabel?.lowercased() == self.pokemonName.lowercased())
            XCTAssertTrue(sut.titleLbl.accessibilityTraits == .header)
            expectation.fulfill()
            
        }

        wait(for: [expectation], timeout: 1)

        
    }
    
    func testIDLabelAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "GetData")
        
        DispatchQueue.main.async {
            XCTAssertTrue(sut.idLabel.isAccessibilityElement)
            XCTAssertTrue(sut.idLabel.accessibilityLabel?.lowercased() == String(format: "#%d", 1))
            XCTAssertTrue(sut.idLabel.accessibilityTraits == .staticText)
            expectation.fulfill()
            
        }

        wait(for: [expectation], timeout: 1)

        
    }
    
    func testPokeballImageViewAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(sut.pokeballImageView.isAccessibilityElement)
        
    }
    
    func testPokemonImageViewAcessibility() throws {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(sut.pokemonImageView.isAccessibilityElement)
        
    }
}

