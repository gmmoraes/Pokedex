//
//  NoDataView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

class NoDataView: UIView {
    
    // MARK: - UI

    lazy var imageView: UIImageView = {
        let image = UIImage(named: "noData")
        let tempImgView = UIImageView(image: image)
        
        return tempImgView
    }()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
        configureAcessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAcessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        accessibilityLabel = "No data"
    }


}

extension NoDataView: ViewCodable {

    func buildHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 450).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    }
    
    func configureViews() {
        backgroundColor =  #colorLiteral(red: 0.9803921569, green: 0.9725490196, blue: 0.968627451, alpha: 1) // UIColor(hexString: "#faf8f7")
    }
    
}
