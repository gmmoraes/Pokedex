//
//  PokemonTabController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import UIKit

class PokemonTabController: UITabBarController, UITabBarControllerDelegate {
    
    let viewController1: UIViewController
    let viewController2: UIViewController
    var coordinator: Coordinatable?
    
    lazy var circleView: UIImageView = {
        let image = UIImage(named: "pokeIcon")
        let tempView = UIImageView(image: image)
        tempView.layer.cornerRadius = 30
        
        return tempView
    }()

    private lazy var customTabBar = { () -> CustomTabBar in
        let tabBar = CustomTabBar()
        tabBar.delegate = self
        return tabBar
    }()
    
    init(viewController1: UIViewController, viewController2: UIViewController) {
        self.viewController1 = viewController1
        self.viewController2 = viewController2

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValue(customTabBar, forKey: "tabBar")
        addCircleView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
        // Create Tab one
        let tabOneImg = UIImage(systemName: "list.bullet.rectangle.portrait")
        let tabOneBarItem = UITabBarItem(title: "List", image: tabOneImg, selectedImage: tabOneImg?.withTintColor(.white, renderingMode: .alwaysOriginal))

        viewController1.tabBarItem = tabOneBarItem

        
        // Create Tab two
        let tabTwoImg = UIImage(systemName: "heart")
        let tabTwoBarItem2 = UITabBarItem(title: "Favourites", image: tabTwoImg, selectedImage: tabTwoImg?.withTintColor(.white, renderingMode: .alwaysOriginal))
        
        viewController2.tabBarItem = tabTwoBarItem2
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        self.viewControllers = [viewController1, viewController2]
    }

    
    // MARK: - Private Methods
    
    private func addCircleView() {
        view.addSubview(circleView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        circleView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

    // UITabBarControllerDelegate method

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
