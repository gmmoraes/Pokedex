//
//  PokemonDataViewCell.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonDataViewCell: UITableViewCell {
    
    // MARK: - UI

    private(set) lazy var keyLbl: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = .gray
        tempLabel.font = AppFonts.subTitleFont(size: 14)
        tempLabel.numberOfLines = 0

        return tempLabel
    }()
    
    private(set) lazy var valueLbl: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = .black
        tempLabel.font = AppFonts.subTitleFont(size: 14)
        tempLabel.numberOfLines = 0

        return tempLabel
    }()
    
    // MARK: - Private properties
    
    private var datasource: PokemonTableDatasource?
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        datasource = nil
    }


    // MARK: - Methods

    func updateData(datasource: PokemonTableDatasource?) {
        self.datasource = datasource
        applyViewCode()
        configureAcessibility()
    }
    
    // MARK: - Private Methods
    
    private func configureAcessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        accessibilityLabel = String(format: "%@ : %@", datasource?.keyConstant ?? "", datasource?.valueContants ?? "")
        shouldGroupAccessibilityChildren = true
    }

}

extension PokemonDataViewCell: ViewCodable {

    func buildHierarchy() {
        contentView.addSubview(keyLbl)
        contentView.addSubview(valueLbl)
    }
    
    func setupConstraints() {
        keyLbl.translatesAutoresizingMaskIntoConstraints = false
        keyLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        keyLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        keyLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        keyLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        valueLbl.translatesAutoresizingMaskIntoConstraints = false
        valueLbl.leadingAnchor.constraint(equalTo: keyLbl.trailingAnchor, constant: 10).isActive = true
        valueLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        valueLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        valueLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        valueLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    }
    
    func configureViews() {
        backgroundColor = .clear
        valueLbl.text = datasource?.valueContants ?? ""
        keyLbl.text = datasource?.keyConstant ?? ""
    }
    
}
