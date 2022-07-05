//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class PokemonListView: UIView, NodataPresentable {
    
    // MARK: - Properties
    
    var selectedListModel: ((PokemonListModel) -> Void)?
    var goToError: ((NetworkError) -> Void)?
    
    // MARK: - UI

    private(set) lazy var titleLbl: TitleLabel = {
        let titleLabelDatasource = TitleLabelDatasource(title: PokemonListConstants.titleText, shouldBeAcessible: true)
        let tempLabel = TitleLabel(datasource: titleLabelDatasource)
        return tempLabel
    }()
    
    private(set) lazy var pokeballImageView = PokeballImageView()
    
    private(set) lazy var pokemonTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(PokemonListViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.prefetchDataSource = tableViewManager
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - private properties

    private let cellReuseIdentifier = "PokemonListViewCell"
    private var tableViewManager: TableViewManager<PokemonListModel>? {
        didSet {
            if tableViewManager != nil {
                DispatchQueue.main.async {
                    self.applyViewCode()
                }
            }
        }
    }
    private var viewModel: PokemonListViewModelProtocol
    

    // MARK: - Init

    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        tableviewDataDidLoad(viewModel.pokemonList)
        bindSelectedRow()
        prefetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func prefetchData() {
        tableViewManager?.prefetchRowsAt = { [weak self] indexpaths in
            
            for indexpath in indexpaths {
                self?.prefetchData(indexPath: indexpath)
            }
    
        }
    }
    
    func updateNoViewsData() {
        pokemonTableView.backgroundView = viewModel.pokemonList.count == 0 ? NoDataView() : nil
        pokemonTableView.backgroundView?.backgroundColor = .clear
    }

    
    // MARK: - private methods

    private func tableviewDataDidLoad(_ models: [PokemonListModel]) {
        let manager = TableViewManager(
            models: models,
            reuseIdentifier: cellReuseIdentifier
        ) { datasource, cell in
            guard let cell = cell as? PokemonListViewCell else { return }
            cell.updateData(datasource: datasource)
        }

    //        // We also need to keep a strong reference to the data source,
    //        // since UITableView only uses a weak reference for it.
        tableViewManager = manager
    }
    
    private func bindSelectedRow() {
        tableViewManager?.selectedRow = { [weak self] row in
            if let listModel = self?.viewModel.pokemonList[row] {
                self?.selectedListModel?(listModel)
            }
        }
    }
        
    private func prefetchData(indexPath: IndexPath) {
        viewModel.preFetchData(indexPath: indexPath) { [weak self] result in
            switch result {
            case .success(let resultIndex):
                self?.tableViewManager?.models = self?.viewModel.pokemonList ?? []
                self?.updateRow()
            case .failure(let error):
                self?.goToError?(error)
            }
        }
    }
    
    func updateRow() {
        DispatchQueue.main.async { [self] in
            self.pokemonTableView.reloadData()
        }
    }
    
    


}

extension PokemonListView: ViewCodable {

    func buildHierarchy() {
        addSubview(titleLbl)
        addSubview(pokeballImageView)
        addSubview(pokemonTableView)
    }
    
    func setupConstraints() {
        
        pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
        pokeballImageView.widthAnchor.constraint(equalToConstant: 380).isActive = true
        pokeballImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        pokeballImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 170).isActive = true
        pokeballImageView.topAnchor.constraint(equalTo: topAnchor,constant: -50).isActive = true
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: pokeballImageView.centerYAnchor,constant: 30).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        pokemonTableView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 10).isActive = true
        pokemonTableView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        pokemonTableView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20).isActive = true
        pokemonTableView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
    }
    
    func configureViews() {
        backgroundColor =  AppColor.mainColor()
        updateNoViewsData()
    }
    
}

