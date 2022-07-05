//
//  PokeballImageView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import UIKit


class PokeballImageView: UIView {
    
    // MARK: UI
    
    private(set) lazy var imageView: UIImageView = {
        let image = UIImage(named: PokemonListConstants.pokeballImageStr)
        let tempImgView = UIImageView(image: image)
        tempImgView.alpha = 0.3
        
        return tempImgView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokeballImageView: ViewCodable {
    func buildHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configureViews() {
        backgroundColor = .clear
    }
}
