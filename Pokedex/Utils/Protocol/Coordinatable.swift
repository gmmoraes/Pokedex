//
//  Coordinatable.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

protocol ErrorManageable {
    var action: (() -> Void)? { get set}
    func goToError(errorData: NetworkError, goToRoot: Bool)
}

protocol Coordinatable: NSObject, ErrorManageable {
    var identifier: UUID { get }
    var childCoordinators: [UUID: Coordinatable] { get set }
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinatable? { get set }

    func start()
    func store(coordinator: Coordinatable)
    func free(coordinator: Coordinatable)
}

extension Coordinatable {
    
    func popToController(child: Coordinatable, destination: Coordinatable) {
        free(coordinator: child)
        navigationController.popViewController(animated: false)
        destination.start()
    }
    
    func pop(animated: Bool) {
        parentCoordinator?.free(coordinator: self)
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        self.parentCoordinator = nil
        childCoordinators = [:]
        let controllers = navigationController.viewControllers
        for controller in controllers {
            if controller is PokemonTabController {
                navigationController.popToViewController(controller, animated: true)
            }
        }
    }
    
    func coordinate(to coordinator: Coordinatable) {
        store(coordinator: coordinator)
        coordinator.start()
    }
    
    /// Stores coordinator to the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Child coordinator to store.
    func store(coordinator: Coordinatable) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parentCoordinator = self
    }

    /// Release coordinator from the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Coordinator to release.
    func free(coordinator: Coordinatable) {
        childCoordinators[coordinator.identifier] = nil
        coordinator.parentCoordinator = nil
    }
    
    func goToError(errorData: NetworkError, goToRoot: Bool) {
        let vc = ErrorViewController(errorData: errorData, goToRoot: goToRoot)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
