//
//  PokemonInformationCoordinatorTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonInformationCoordinatorTests: XCTestCase {

    var navigationController: NavigationControllerSpy!
    var sut: PokemonInformationCoordinator?

    override func setUpWithError() throws {
        navigationController = NavigationControllerSpy()
        sut = PokemonInformationCoordinator(navigationController: navigationController, viewModel: PokemonInformationViewModel(listModel: nil))
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
    }

    func testStart() throws {
        
        // Given

        guard let sut = sut else {
            XCTFail()
            return
        }
        
        // When
        
        sut.start()
        
        // Then
        
        XCTAssertTrue(navigationController.viewControllerWasPushed)
        XCTAssertTrue(navigationController.viewControllerToPresent is PokemonInformationViewController)
    }
    
    func testGoToError() throws {
        
        // Given

        guard let sut = sut else {
            XCTFail()
            return
        }
        
        // When
        
        sut.goToError(errorData: .somethingWentWrong, goToRoot: true)
        
        // Then
        
        XCTAssertTrue(navigationController.viewControllerWasPushed)
        XCTAssertTrue(navigationController.viewControllerToPresent is ErrorViewController)
    }

}
