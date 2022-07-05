//
//  FavoritePokemonListView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class FavoritePokemonListView: UIView, NodataPresentable {
    
    // MARK: - Properties
    
    var selectedPokemonModel: ((PokemonInformationModel) -> Void)?
    var goToError: ((NetworkError) -> Void)?
    let titleText = "Favourites"
    var shouldShowNodataView: Bool = false
    
    // MARK: - UI

    lazy var titleLbl: TitleLabel = {
        let titleLabelDatasource = TitleLabelDatasource(title: titleText, shouldBeAcessible: true)
        let tempLabel = TitleLabel(datasource: titleLabelDatasource)
        return tempLabel
    }()
    
    private(set) lazy var pokeballImageView = PokeballImageView()

    
    private lazy var pokemonListCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let size = CGSize(width: 500, height: 500)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.delegate = collectionViewManager
        collectionView.dataSource = collectionViewManager
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return collectionView
    }()
    
    // MARK: - private properties

    private let cellReuseIdentifier = "FavouritesCollectionViewCell"
    private var collectionViewManager: CollectionViewManager<PokemonInformationModel>? {
        didSet {
            if collectionViewManager != nil {
                bindSelectedRow()
                applyViewCode()
            }
        }
    }
    private let viewModel: FavoritePokemonViewModelProtocol

    // MARK: - Init

    init(viewModel: FavoritePokemonViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -  methods
    
    func update() {
        getFavouritePokemon()
    }
    
    func updateNoViewsData() {
         pokemonListCollectionView.backgroundView = shouldShowNodataView ? NoDataView() : nil
         pokemonListCollectionView.backgroundView?.backgroundColor = .clear
     }
    
    // MARK: - private methods

    private func collectionViewDataDidLoad(_ models: [PokemonInformationModel]) {
        let manager = CollectionViewManager(
            models: models,
            reuseIdentifier: cellReuseIdentifier
        ) { model, cell in
            guard let cell = cell as? FavouritesCollectionViewCell else { return }
            let theme: ListCollectionTheme = ListCollectionTheme(shadowOffsetWidth: 0, shadowColor: .black, shadowOffsetHeight: 3, shadowOpacity: 0.2, maskedCorners: nil, cornerRadius: 8, masksToBounds: true)
            cell.updateData(model: model, theme: theme)
        }

//        // We also need to keep a strong reference to the data source,
//        // since UITableView only uses a weak reference for it.
        collectionViewManager = manager
    }
    
    private func getFavouritePokemon() {
        viewModel.getFavouritePokemon() { [weak self] result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self?.shouldShowNodataView = pokemons.count == 0
                    if let manager = self?.collectionViewManager {
                        manager.models = pokemons
                    } else {
                        self?.collectionViewDataDidLoad(pokemons)
                    }
                    self?.updateNoViewsData()
                    self?.pokemonListCollectionView.reloadData()
                }
            case .failure(let error):
                self?.goToError?(error)
            }
        }
    }

    private func bindSelectedRow() {
        collectionViewManager?.selectedRow = { [weak self] row in
            if let pokemonModel = self?.viewModel.pokemonModels[row] {
                self?.selectedPokemonModel?(pokemonModel)
            }
        }
    }
    
    private func bindPrefetchedRow() {
        collectionViewManager?.prefetchRowsAt = { [weak self] indexpaths in
            
            for indexpath in indexpaths {
                self?.prefetchData(indexPath: indexpath)
            }
    
        }
    }
    
    private func prefetchData(indexPath: IndexPath) {
        viewModel.preFetchData(indexPath: indexPath) { [weak self] result in
            switch result {
            case .success(let resultIndex):
                self?.collectionViewManager?.models = self?.viewModel.pokemonModels ?? []
                self?.updateRow(indexPath: resultIndex)
            case .failure(let error):
                self?.goToError?(error)
            }
        }
    }
    
    private func updateRow(indexPath: IndexPath) {
        DispatchQueue.main.async { [self] in
            self.pokemonListCollectionView.reloadItems(at: [indexPath])
        }
    }



}

extension FavoritePokemonListView: ViewCodable {

    func buildHierarchy() {
        addSubview(titleLbl)
        addSubview(pokeballImageView)
        addSubview(pokemonListCollectionView)
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
        
        pokemonListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pokemonListCollectionView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 10).isActive = true
        pokemonListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        pokemonListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        pokemonListCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10).isActive = true
    }
    
    func configureViews() {
        backgroundColor =  AppColor.mainColor()
        updateNoViewsData()
    }
    
}
