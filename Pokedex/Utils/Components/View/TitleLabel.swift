//
//  TitleLabel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 04/07/22.
//

import UIKit


struct TitleLabelDatasource {
    var title: String
    var shouldBeAcessible: Bool
    var aligment: NSTextAlignment = .left
    var color: UIColor = .black
}

class TitleLabel: UILabel {
    
    private let datasource: TitleLabelDatasource

    // MARK: - Init

    init(datasource: TitleLabelDatasource) {
        self.datasource = datasource
        super.init(frame: CGRect.zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        textColor = datasource.color
        text = datasource.title
        font = AppFonts.titleFont()
        textAlignment = datasource.aligment
        isAccessibilityElement = datasource.shouldBeAcessible

        if datasource.shouldBeAcessible {
            accessibilityTraits = .header
            accessibilityLabel = datasource.title
        }
        
    }
}
