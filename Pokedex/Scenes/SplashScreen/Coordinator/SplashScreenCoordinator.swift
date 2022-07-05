//
//  SplashScreenCoordinator.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class SplashScreenCoordinator: NSObject, Coordinatable {

    var action: (() -> Void)?
    var identifier: UUID = UUID()
    var childCoordinators = [UUID : Coordinatable]()
    let viewModel: PokemonListViewModelProtocol
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinatable?
    
    // MARK: - Private Properties
    
    let viewController: SplashScreenViewController

    init(navigationController: UINavigationController, viewModel: PokemonListViewModelProtocol = PokemonListViewModel()) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.viewController = SplashScreenViewController(viewModel: viewModel)
        super.init()
        self.action = { [weak self] in
            self?.viewController.retry()
        }
    }

    func start() {
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToPokemonList() {
        let pokemonTabCoordinator = PokemonTabCoordinator(navigationController: navigationController, viewModel: viewModel)
        parentCoordinator?.popToController(child: self, destination: pokemonTabCoordinator)
    }
    
}
