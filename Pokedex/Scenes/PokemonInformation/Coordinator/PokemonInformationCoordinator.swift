//
//  PokemonInformationCoordinator.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonInformationCoordinator: NSObject, Coordinatable {

    var action: (() -> Void)?
    var identifier: UUID = UUID()
    var childCoordinators = [UUID : Coordinatable]()
    let viewModel: PokemonInformationViewModelProtocol
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinatable?

    init(navigationController: UINavigationController, viewModel: PokemonInformationViewModelProtocol) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        super.init()
        self.action = { [weak self] in
            self?.popToRoot(animated: true)
        }
    }
    
    convenience init(navigationController: UINavigationController, listModel: PokemonListModel?, informationModel: PokemonInformationModel?) {
        self.init(navigationController: navigationController, viewModel: PokemonInformationViewModel(listModel: listModel, informationModel: informationModel))
    }

    func start() {
        let vc = PokemonInformationViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

}
