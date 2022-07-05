//
//  PokemonInformationViewModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import CoreData
import Network
import UIKit

protocol PokemonInformationViewModelProtocol {
    var pokemonImage: ((UIImage) -> Void)? { get set}
    var isFavourited: ((Bool) -> Void)? { get set}
    
    func getData(completionHandler: @escaping (Result<PokemonInformationModel, NetworkError>) -> Void)
    func toggleFavourite()
    func checkisFavourited() -> Bool
}

final class PokemonInformationViewModel {
    
    // MARK: - Properties

    var pokemonImage: ((UIImage) -> Void)?
    var isFavourited: ((Bool) -> Void)?
    var model: PokemonInformationModel? {
        didSet {
            if let model = model {
                isFavourited?(model.isFavourited)
            }
        }
    }
    

    // MARK: - Private Properties

    private let coreDataManager: CoredataManager
    private var service: Serviceable
    private var listModel: PokemonListModel?
    private let adapter = PokemonModelAdapter()


    // MARK: - Init
    
    init(listModel: PokemonListModel?, informationModel: PokemonInformationModel? = nil, service: Serviceable = PokemonService(resultType: PokemonInformationModel.self), coreDataManager: CoredataManager = CoredataManager()) {
        self.service = service
        self.model = informationModel
        self.listModel = listModel
        self.coreDataManager = coreDataManager
    }

    
    // MARK: - Private methods
    
    private func downloadImage(model: PokemonInformationModel, urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        let requestInfo = ImageDownloaderRequestInfo(id: model.id, url: url)
        ImageDownloader.shared.loadImage(requestInfo: requestInfo) { [weak self] image in
            self?.pokemonImage?(image)
            self?.coreDataManager.updatePokemonImage(model: model, image: image)
        }
    }
    
    private func storePokemons(model: PokemonInformationModel) {
        coreDataManager.savePokemon(model: model, image: nil)
    }
    
    private func checkIfPokemonExists() -> PokemonInformationModel? {
        if model != nil {
            return model
        }
        guard let pokemon = coreDataManager.getPokemon(name: listModel?.name ?? "") else { return nil }
        let model = adapter.createModel(data: pokemon)
        self.model = model
        
        if model.sprites.image == nil {
            downloadImage(model: model, urlStr: model.sprites.other.officialArtwork.url)
        }
        
        return model
    }
    
    private func fetchData(completionHandler: @escaping (Result<PokemonInformationModel, NetworkError>) -> Void) {

        service.fetchOne(from: listModel?.urlStr ?? "") { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data as? PokemonInformationModel {
                    self?.model = data
                    self?.storePokemons(model: data)
                    self?.downloadImage(model: data, urlStr: data.sprites.other.officialArtwork.url)
                    completionHandler(.success(data))
                } else {
                    completionHandler(.failure(.somethingWentWrong))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}

extension PokemonInformationViewModel: PokemonInformationViewModelProtocol {
    func getData(completionHandler: @escaping (Result<PokemonInformationModel, NetworkError>) -> Void) {
        
        if let model = checkIfPokemonExists() {
            completionHandler(.success(model))
            return
        }
        
        fetchData(completionHandler: completionHandler)
    }


    func toggleFavourite() {
        guard var tempModel = model else { return }
        tempModel.isFavourited = !tempModel.isFavourited
        isFavourited?(tempModel.isFavourited)
        coreDataManager.togglePokemonFavourite(model: tempModel)
        self.model = tempModel
    }
    
    func checkisFavourited() -> Bool {
        model?.isFavourited ?? false
    }
}
