//
//  PokemonInformationView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonInformationView: UIView {
    
    // MARK: - Properties
    
    var goToError: ((NetworkError) -> Void)?
    
    // MARK: - UI

    lazy var titleLbl: TitleLabel = {
        let titleLabelDatasource = TitleLabelDatasource(title: datasource?.name.firstUppercased ?? "", shouldBeAcessible: true, color: .white)
        let tempLabel = TitleLabel(datasource: titleLabelDatasource)
        return tempLabel
    }()
    
    private(set) lazy var pokeballImageView = PokeballImageView()
    
    lazy var idLabel: UILabel = {
        let tempLabel = UILabel()
        let mainString = String(format: "#%d", datasource?.id ?? 0)
        tempLabel.textColor = .white
        tempLabel.text = mainString
        tempLabel.font = AppFonts.titleFont()
        tempLabel.isAccessibilityElement = true
        tempLabel.accessibilityTraits = .staticText
        tempLabel.accessibilityLabel = mainString
        
        return tempLabel
    }()

    
    private lazy var pokemonTypesCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        let size = CGSize(width: 500, height: 500)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(PokemonTypeCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.delegate = collectionViewManager
        collectionView.dataSource = collectionViewManager
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return collectionView
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let image = datasource?.sprites.image ?? UIImage(named: "empty")
        let tempImgView = UIImageView(image: image)
        tempImgView.isAccessibilityElement = false
        
        return tempImgView
    }()
    
    let child = SpinnerViewController()
    
    // MARK: - Properties

    var dataView: PokemonTableDataView?
    
    // MARK: - private properties

    private let cellReuseIdentifier = "PokemonTypeCollectionViewCell"
    private var collectionViewManager: CollectionViewManager<TypesModel>? {
        didSet {
            if collectionViewManager != nil {
                DispatchQueue.main.async {
                    self.stopSpinnerView()
                    self.applyViewCode()
                }
            }
        }
    }
    private var datasource: PokemonInformationModel?
    private var viewModel: PokemonInformationViewModelProtocol

    // MARK: - Init

    init(viewModel: PokemonInformationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func bindView() {
        startSpinnerView()
        bindViewModel()
        bindToPokemonImage()
    }

    
    // MARK: - private methods

    private func collectionViewDataDidLoad(_ models: [TypesModel]) {
        let manager = CollectionViewManager(
            models: models,
            reuseIdentifier: cellReuseIdentifier
        ) { datasource, cell in
            guard let cell = cell as? PokemonTypeCollectionViewCell else { return }
            cell.datasource = datasource
        }

//        // We also need to keep a strong reference to the data source,
//        // since UITableView only uses a weak reference for it.
        collectionViewManager = manager
    }
    
    private func bindViewModel() {
        viewModel.getData() { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dataView = PokemonTableDataView(datasource: data)
                    self?.datasource = data
                    let typeModel = data.typeElements.compactMap{$0.type}
                    self?.collectionViewDataDidLoad(typeModel)
                }
            case .failure(let error):
                self?.goToError?(error)
            }
        }
    }
    
    private func bindToPokemonImage() {
        viewModel.pokemonImage = { [weak self] pokemonImage in
            DispatchQueue.main.async {
                self?.pokemonImageView.image = pokemonImage
                self?.layoutIfNeeded()
            }
        }
    }
    
    private func startSpinnerView() {
        DispatchQueue.main.async {
            self.child.view.frame = self.frame
            self.addSubview(self.child.view)

            self.child.view.translatesAutoresizingMaskIntoConstraints = false
            self.child.view.widthAnchor.constraint(equalToConstant: 10).isActive = true
            self.child.view.heightAnchor.constraint(equalToConstant: 10).isActive = true
            self.child.view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.child.view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    private func stopSpinnerView() {
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }


}

extension PokemonInformationView: ViewCodable {

    func buildHierarchy() {
        guard let dataView = dataView else { return }

        addSubview(titleLbl)
        addSubview(idLabel)
        addSubview(pokeballImageView)
        addSubview(pokemonTypesCollectionView)
        addSubview(dataView)
        addSubview(pokemonImageView)
    }
    
    func setupConstraints() {

        guard let dataView = dataView else { return }
        
        // pokeballImageView

        pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
        pokeballImageView.widthAnchor.constraint(equalToConstant: 380).isActive = true
        pokeballImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        pokeballImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 110).isActive = true
        pokeballImageView.bottomAnchor.constraint(equalTo: dataView.topAnchor,constant: 30).isActive = true
        
        // titleLbl
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: idLabel.leadingAnchor,constant: -10).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // idLabel
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.topAnchor.constraint(equalTo: titleLbl.topAnchor).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // pokemonTypesCollectionView

        pokemonTypesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypesCollectionView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor,constant: 10).isActive = true
        pokemonTypesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 5).isActive = true
        pokemonTypesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        pokemonTypesCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // pokemonImageView

        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.bottomAnchor.constraint(equalTo: dataView.topAnchor,constant: 17).isActive = true
        pokemonImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        pokemonImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // dataView

        dataView.translatesAutoresizingMaskIntoConstraints = false
        dataView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        dataView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        dataView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        dataView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    func configureViews() {
        if let mainType = datasource?.typeElements.first?.type {
            backgroundColor = TypesValues(rawValue: mainType.name.lowercased())?.getMainColor()
        }
        
        dataView?.backgroundColor = .white
    }
    
}
