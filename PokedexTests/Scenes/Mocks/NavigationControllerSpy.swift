//
//  NavigationControllerSpy.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import UIKit

class NavigationControllerSpy: UINavigationController {
    
    var viewControllerWasPushed = false
    var viewControllerWasPoped = false
    var viewControllerToPresent: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllerWasPushed = true
        viewControllerToPresent = viewController
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        viewControllerWasPoped = true
        return nil
    }
    
}
