//
//  SplashScreenViewController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private var mainView: SplashScreenView
    weak var coordinator: SplashScreenCoordinator?

    init(viewModel: PokemonListViewModelProtocol) {
        self.mainView = SplashScreenView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    override func loadView() {
        view = mainView
    }
    
    // MARK: - Methods
    
    func retry() {
        mainView.getData()
    }
    
    // MARK: - Private methods

    private func bindView() {
        mainView.bindData = { [weak self] result in
            switch result {
            case .success(let _):
                DispatchQueue.main.async {
                    self?.coordinator?.goToPokemonList()
                }
            case .failure(let error):
                self?.coordinator?.goToError(errorData: error, goToRoot: false)
            }
        }
    }
}

