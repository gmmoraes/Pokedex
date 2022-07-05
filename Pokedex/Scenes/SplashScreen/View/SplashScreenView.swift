//
//  SplashScreenView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit


class SplashScreenView: UIView {
    
    
    // MARK: - Properties
    
    var bindData: ((Result<[PokemonListModel], NetworkError>) -> Void)?
    
    // MARK: - UI

    private(set) lazy var pokemonImageView: UIImageView = {
        let image = UIImage(named: "p0")
        let tempImgView = UIImageView(image: image)
        
        return tempImgView
    }()
    
    // MARK: - private properties

    private var viewModel: PokemonListViewModelProtocol
    private var timer = Timer()

    

    // MARK: - Init

    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        applyViewCode()
        getData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - methods

    
    func getData() {
        viewModel.fetchData() { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.timer.invalidate()
                self?.bindData?(result)
            }
        }
    }
    
    // MARK: - private methods
    
    @objc private func changeImage() {
        let randomInt = Int.random(in: 0..<10)
        let imageStr = String(format: "p%d", randomInt)
        let newImage = UIImage(named: imageStr)
        UIView.transition(with: pokemonImageView,
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in self?.pokemonImageView.image = newImage },
                          completion: nil)
    }


}

extension SplashScreenView: ViewCodable {

    func buildHierarchy() {
        addSubview(pokemonImageView)
    }
    
    func setupConstraints() {
        
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pokemonImageView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
    }
    
    func configureViews() {
        backgroundColor = AppColor.mainColor()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
}

