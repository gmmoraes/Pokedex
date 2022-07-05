//
//  FavoritePokemonViewController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import UIKit

class FavoritePokemonViewController: UIViewController {
    
    private var mainView: FavoritePokemonListView
    weak var coordinator: Coordinatable?

    // MARK: - Init

    init(viewModel: FavoritePokemonViewModelProtocol) {
        self.mainView = FavoritePokemonListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindView()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func loadView() {
        view = mainView
    }

    private func bindView() {
        mainView.selectedPokemonModel = { [weak self] model in
            DispatchQueue.main.async {
                if let coordinator = self?.coordinator as? PokemonTabCoordinator {
                    coordinator.goToPokemonInformation(listModel: nil, informationModel: model)
                }
            }
        }
        
        mainView.goToError = { [weak self] errorContent in
            DispatchQueue.main.async {
                self?.coordinator?.goToError(errorData: errorContent, goToRoot: false)
            }
        }
        
        mainView.update()
    }
}

