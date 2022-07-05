//
//  ViewCodable.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import Foundation

protocol ViewCodable {

    func buildHierarchy()
    func setupConstraints()
    func configureViews()

}


extension ViewCodable {

    func configureViews() {}
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }

}

