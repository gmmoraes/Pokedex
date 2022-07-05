//
//  FavouritesCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI

    lazy var titleLbl = UILabel()
    lazy var idLbl = UILabel()
    lazy var pokemonImageView = UIImageView()
    
    // MARK: - Properties

    var model: PokemonInformationModel?
    var theme: ListCollectionTheme?
    
    // MARK: - Private properties

    private let titleHeigthConstant: CGFloat = 30
    private let idHeigthConstant: CGFloat = 20
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides

    override func layoutSubviews() {
        if let cornerRadius = theme?.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        
        if let maskedCorners  = theme?.maskedCorners  {
            layer.maskedCorners  = maskedCorners
        }
        
        if let masksToBounds = theme?.masksToBounds {
            layer.masksToBounds = masksToBounds
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl = UILabel()
        pokemonImageView = UIImageView()
        model = nil
    }
    
    // MARK: - Methods
    
    func updateData(model: PokemonInformationModel, theme: ListCollectionTheme) {
        self.model = model
        self.theme = theme

        configureUI()
        applyViewCode()
        configureAcessibility()
    }

    // MARK: - Private methods

    private func configureUI() {
        guard let model = model else {
            return
        }
        
        // titleLbl

        titleLbl.textColor = .white
        titleLbl.text = model.name.firstUppercased
        titleLbl.font = AppFonts.titleFont(size: 16)
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
    
        // idLbl

        idLbl.textColor = .white
        idLbl.text = String(format: "#%d", model.id)
        idLbl.font = AppFonts.subTitleFont(size: 14)
        idLbl.numberOfLines = 0
        idLbl.textAlignment = .center


        // PokemonImageView

        pokemonImageView = UIImageView(image: model.sprites.image)

    }
    
    private func configureAcessibility() {
        guard let model = model else { return }
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        accessibilityLabel = model.name
        shouldGroupAccessibilityChildren = true
    }
}

extension FavouritesCollectionViewCell: ViewCodable {

    func buildHierarchy() {
        contentView.addSubview(titleLbl)
        contentView.addSubview(idLbl)
        contentView.addSubview(pokemonImageView)
    }
    
    func setupConstraints() {
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: titleHeigthConstant).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true

        idLbl.translatesAutoresizingMaskIntoConstraints = false
        idLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5).isActive = true
        idLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: idHeigthConstant).isActive = true
        idLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        idLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: 10).isActive = true
        pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pokemonImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    func configureViews() {
        if let mainType = model?.typeElements.first?.type {
            backgroundColor = TypesValues(rawValue: mainType.name.lowercased())?.getMainColor()
        }
    }
    
}

