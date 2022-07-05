//
//  PokemonInformationViewController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonInformationViewController: UIViewController {
    
    private var mainView: PokemonInformationView
    private var viewModel: PokemonInformationViewModelProtocol
    weak var coordinator: Coordinatable?

    init(viewModel: PokemonInformationViewModelProtocol) {
        self.viewModel = viewModel
        self.mainView = PokemonInformationView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.customizeNavbar(isSelected: self.viewModel.checkisFavourited())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func customizeNavbar(isSelected: Bool) {
        DispatchQueue.main.async {
            let cancelButton = UIButton()
            cancelButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            cancelButton.tintColor = .white
            cancelButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            cancelButton.addTarget(self, action: #selector(self.pop), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: cancelButton)

            self.navigationItem.setLeftBarButtonItems([item1], animated: false)
            
            let favouriteImage = isSelected ? "heart.fill" : "heart"
            let favouriteButton = UIButton()
            favouriteButton.setImage(UIImage(systemName: favouriteImage), for: .normal)
            favouriteButton.tintColor = isSelected ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            favouriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            favouriteButton.addTarget(self, action: #selector(self.toogleFavorite), for: .touchUpInside)
            favouriteButton.isAccessibilityElement = true
            favouriteButton.accessibilityTraits = .button
            let rigthItem = UIBarButtonItem(customView: favouriteButton)
            rigthItem.isAccessibilityElement = true
            rigthItem.accessibilityTraits = .button

            self.navigationItem.setRightBarButtonItems([rigthItem], animated: false)
        }
    }
    
    @objc
    private func pop() {
        coordinator?.pop(animated: true)
    }

    @objc
    private func toogleFavorite() {
        viewModel.toggleFavourite()
    }
    
    private func bindView() {
        viewModel.isFavourited = { [weak self] isFavourited in
            DispatchQueue.main.async {
                self?.customizeNavbar(isSelected: isFavourited)
            }
        }
        
        mainView.goToError = { [weak self] errorContent in
            DispatchQueue.main.async {
                self?.coordinator?.goToError(errorData: errorContent, goToRoot: true)
            }
        }
        
        mainView.bindView()
    }
}

