//
//  PokemonTabCoordinatorTests.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

@testable import Pokedex
import XCTest

class PokemonTabCoordinatorTests: XCTestCase {

    var navigationController: NavigationControllerSpy!
    var sut: PokemonTabCoordinator?

    override func setUpWithError() throws {
        navigationController = NavigationControllerSpy()
        sut = PokemonTabCoordinator(navigationController: navigationController)
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
        XCTAssertTrue(navigationController.viewControllerToPresent is PokemonTabController)
    }
    
    func testGoToPokemonInformation() throws {
        
        // Given

        guard let sut = sut else {
            XCTFail()
            return
        }
        
        // When
        
        sut.goToPokemonInformation(listModel: nil, informationModel: nil)
        
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
        
        sut.goToError(errorData: .somethingWentWrong, goToRoot: false)
        
        // Then
        
        XCTAssertTrue(navigationController.viewControllerWasPushed)
        XCTAssertTrue(navigationController.viewControllerToPresent is ErrorViewController)
    }


}
