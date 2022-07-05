//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private var mainView: PokemonListView
    weak var coordinator: Coordinatable?

    // MARK: - Init

    init(viewModel: PokemonListViewModelProtocol) {
        self.mainView = PokemonListView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func loadView() {
        view = mainView
    }
    
    // MARK: - Methods
    
    func retry() {
        mainView.prefetchData()
    }
    
    // MARK: - Private methods
    
    private func bindView() {
        mainView.selectedListModel = { [weak self] listModel in
            DispatchQueue.main.async {
                if let coordinator = self?.coordinator as? PokemonTabCoordinator {
                    coordinator.goToPokemonInformation(listModel: listModel, informationModel: nil)
                }
            }
        }
        
        mainView.goToError = { [weak self] errorContent in
            DispatchQueue.main.async {
                self?.coordinator?.goToError(errorData: errorContent, goToRoot: false)
            }
        }
    }
}

