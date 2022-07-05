//
//  PokemonTypeCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonTypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI

    lazy var titleLbl = UILabel()
    
    // MARK: - Properties

    var datasource: TypesModel? {
        didSet {
            if datasource != nil {
                configureUI()
                applyViewCode()
                configureAcessibility()
            }
        }
    }
    
    // MARK: - Private properties

    private let titleHeigthConstant: CGFloat = 30
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides

    override func layoutSubviews() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl = UILabel()
        datasource = nil
    }

    // MARK: - Private methods

    private func configureUI() {
        guard let datasource = datasource else {
            return
        }
        
        // titleLbl

        titleLbl.textColor = .white
        titleLbl.text = datasource.name
        titleLbl.font = AppFonts.subTitleFont()
        titleLbl.textAlignment = .center

    }
    
    private func configureAcessibility() {
        guard let datasource = datasource else { return }
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        accessibilityLabel = datasource.name
        shouldGroupAccessibilityChildren = true
    }
}

extension PokemonTypeCollectionViewCell: ViewCodable {

    func buildHierarchy() {
        contentView.addSubview(titleLbl)
    }
    
    func setupConstraints() {
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true

    }
    
    func configureViews() {
        if let datasource = datasource {
            backgroundColor = TypesValues(rawValue: datasource.name.lowercased())?.getSubColor()
        }
    }
    
}

