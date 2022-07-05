//
//  PokemonTabCoordinator.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class PokemonTabCoordinator: NSObject, Coordinatable {

    var action: (() -> Void)?
    var identifier: UUID = UUID()
    var childCoordinators = [UUID : Coordinatable]()
    let viewModel: PokemonListViewModelProtocol
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinatable?
    
    // MARK: Private Properties
    let pokemonListViewController: PokemonListViewController

    init(navigationController: UINavigationController, viewModel: PokemonListViewModelProtocol = PokemonListViewModel()) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.pokemonListViewController = PokemonListViewController(viewModel: viewModel)
        super.init()
        self.action = { [weak self] in
            self?.pokemonListViewController.retry()
        }
    }

    func start() {
        let pokemonTabController = pokemonTabControllerMake()
        navigationController.pushViewController(pokemonTabController, animated: true)
    }
    
    func goToPokemonInformation(listModel: PokemonListModel?, informationModel: PokemonInformationModel?) {
        let coordinator = PokemonInformationCoordinator(navigationController: navigationController, listModel: listModel, informationModel: informationModel)
        coordinator.parentCoordinator = self
        store(coordinator: coordinator)
        coordinator.start()
    }
    
    // MARK: - Private methods
    
    private func pokemonTabControllerMake() -> PokemonTabController {
        pokemonListViewController.coordinator = self
        let vc2 = FavoritePokemonViewController(viewModel: FavoritePokemonViewModel())
        vc2.coordinator = self
        let pokeTabController = PokemonTabController(viewController1: pokemonListViewController, viewController2: vc2)
        pokeTabController.coordinator = self
        
        return pokeTabController
    }
    
}
