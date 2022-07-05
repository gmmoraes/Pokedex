//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class AppCoordinator : NSObject, Coordinatable {

    var action: (() -> Void)?
    var identifier: UUID = UUID()
    var childCoordinators: [UUID : Coordinatable] = [:]
    var navigationController: UINavigationController = UINavigationController()
    let window : UIWindow
    weak var parentCoordinator: Coordinatable?

    init(window: UIWindow) {
        self.window = window
        super.init()
        self.action = { [weak self] in
            self?.pop(animated: true)
        }
    }
    
    
    func start() {
        let coordinator = SplashScreenCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        coordinate(to: coordinator)
    }

}

