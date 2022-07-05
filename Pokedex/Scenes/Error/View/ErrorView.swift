//
//  ErrorView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 03/07/22.
//

import UIKit

class ErrorView: UIView {
    
    // MARK: - Properties
    
    var didTryAgain: (() -> Void)?
    
    // MARK: - UI

    lazy var imageView: UIImageView = {
        let image = UIImage(named: "errorIcon")
        let tempImgView = UIImageView(image: image)
        tempImgView.isAccessibilityElement = false
        
        return tempImgView
    }()
    
    lazy var titleLbl: TitleLabel = {
        let titleLabelDatasource = TitleLabelDatasource(title: title, shouldBeAcessible: true, aligment: .center)
        let tempLabel = TitleLabel(datasource: titleLabelDatasource)
        return tempLabel
    }()
    
    lazy var tryAgainButton: UIButton = {
        let tempButton = UIButton()
        tempButton.backgroundColor = AppColor.subColor()
        tempButton.setTitle("Try Again", for: .normal)
        tempButton.isAccessibilityElement = true
        tempButton.accessibilityLabel = "Try Again"
        tempButton.accessibilityTraits = .button
        tempButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        return tempButton
    }()
    
    // MARK: Properties
    
    private let title: String


    // MARK: - Init

    init(title: String) {
        self.title = title
        super.init(frame: CGRect.zero)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tryAgain() {
        didTryAgain?()
    }

}

extension ErrorView: ViewCodable {

    func buildHierarchy() {
        addSubview(imageView)
        addSubview(titleLbl)
        addSubview(tryAgainButton)
    }
    
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(greaterThanOrEqualTo: titleLbl.topAnchor,constant: -10).isActive = true
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: tryAgainButton.topAnchor, constant: -10).isActive = true
        
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tryAgainButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tryAgainButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        tryAgainButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

    }
    
    func configureViews() {
        backgroundColor =  AppColor.mainColor()
    }
    
}
