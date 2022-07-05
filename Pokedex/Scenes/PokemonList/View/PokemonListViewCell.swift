//
//  PokemonListViewCell.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class PokemonListViewCell: UITableViewCell {
    
    // MARK: - UI

    private(set) lazy var titleLbl: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = .black
        tempLabel.font = AppFonts.subTitleFont()

        return tempLabel
    }()
    
    lazy var pokeballIcon: UIImageView = {
        let image = UIImage(named: "pokeball")
        let tempImgView = UIImageView(image: image)
        
        return tempImgView
    }()
    
    // MARK: - Private properties
    
    private var datasource: PokemonListModel?
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        datasource = nil
        titleLbl.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            configureSelectedCell()
        } else {
            configureUnSelectedCell()
        }
    }

    // MARK: - Methods

    func updateData(datasource: PokemonListModel) {
        self.datasource = datasource
        applyViewCode()
        configureAcessibility()
    }
    
    // MARK: - Private Methods

    private func formatDate(date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: date)
    }
    
    private func configureAcessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        accessibilityLabel = datasource?.name ?? ""
        shouldGroupAccessibilityChildren = true
    }

    private func configureSelectedCell() {
        let elementsColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // UIColor(hexString: "#8e9fef")
        titleLbl.textColor = elementsColor
        contentView.backgroundColor = AppColor.subColor()
    }
    
    private func configureUnSelectedCell() {
        titleLbl.textColor = .black
        contentView.backgroundColor = .clear
    }
}

extension PokemonListViewCell: ViewCodable {

    func buildHierarchy() {
        contentView.addSubview(titleLbl)
        contentView.addSubview(pokeballIcon)
    }
    
    func setupConstraints() {
        pokeballIcon.translatesAutoresizingMaskIntoConstraints = false
        pokeballIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        pokeballIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pokeballIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        pokeballIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.leadingAnchor.constraint(equalTo: pokeballIcon.trailingAnchor, constant: 10).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    }
    
    func configureViews() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        titleLbl.text = datasource?.name.firstUppercased ?? ""
    }
    
}
