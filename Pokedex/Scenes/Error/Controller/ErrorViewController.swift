//
//  ErrorViewController.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 03/07/22.
//

import UIKit

class ErrorViewController: UIViewController {
    
    private let mainView: ErrorView
    private let goToRoot: Bool
    weak var coordinator: Coordinatable?

    // MARK: - Init

    init(errorData: NetworkError, goToRoot: Bool) {
        self.mainView = ErrorView(title: errorData.getTitle())
        self.goToRoot = goToRoot
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
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func bindView() {
        mainView.didTryAgain = { [weak self] in
            self?.coordinator?.action?()
        }
    }
}


