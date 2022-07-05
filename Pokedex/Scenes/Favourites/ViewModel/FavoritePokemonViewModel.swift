//
//  FavoritePokemonViewModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import CoreData
import UIKit

protocol FavoritePokemonViewModelProtocol {
    var pokemonModels: [PokemonInformationModel] { get }

    func preFetchData(indexPath: IndexPath, completionHandler: @escaping (Result<IndexPath, NetworkError>) -> Void) 
    func getFavouritePokemon(limit: Int, completionHandler: @escaping (Result<[PokemonInformationModel], NetworkError>) -> Void)
}

extension FavoritePokemonViewModelProtocol {
    func getFavouritePokemon(limit: Int = 20, completionHandler: @escaping (Result<[PokemonInformationModel], NetworkError>) -> Void){
        getFavouritePokemon(limit: limit, completionHandler: completionHandler)
    }
}

final class FavoritePokemonViewModel {
    
    // MARK: Properties
    
    var pokemonModels: [PokemonInformationModel] = []
    var pokemonImage: ((UIImage) -> Void)?
    

    // MARK: - Private Properties

    private let coreDataManager: CoredataManager
    private var model: PokemonInformationModel?
    private let adapter = PokemonModelAdapter()
    private var indexPathsInUse : [IndexPath: Bool] = [:]
    
    
    // MARK: Init
    
    init(coreDataManager: CoredataManager = CoredataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func checkIfIndexPathIsValid(indexPath: IndexPath) -> Bool {
        if indexPath.row < pokemonModels.count - 10 {
            return false
        }
        
        if indexPathsInUse[indexPath] ?? false {
            return false
        }
        
        return true
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

}

extension FavoritePokemonViewModel: FavoritePokemonViewModelProtocol {
    
    func preFetchData(indexPath: IndexPath, completionHandler: @escaping (Result<IndexPath, NetworkError>) -> Void) {

        if !checkIfIndexPathIsValid(indexPath: indexPath) {
            return
        }
    
        indexPathsInUse[indexPath] = true

        getFavouritePokemon(limit: 1)  { [weak self] result in
            self?.indexPathsInUse[indexPath] = false
            switch result {
            case .success(let pokemons):
                self?.pokemonModels.append(contentsOf: pokemons)
                completionHandler(.success(indexPath))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }

    }
    
    
    func getFavouritePokemon(limit: Int, completionHandler: @escaping (Result<[PokemonInformationModel], NetworkError>) -> Void) {

        coreDataManager.getFavoritedPokemon(limit: limit) { [weak self] result in
            switch result {
            case .success(let pokemons):
                if let models = self?.adapter.createModels(datas: pokemons) {
                    self?.pokemonModels = models
                    completionHandler(.success(models))
                } else {
                    completionHandler(.failure(.somethingWentWrong))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }

//
//        if model.sprites.image == nil {
//            downloadImage(model: model, urlStr: model.sprites.other.officialArtwork.url)
//        }
    }
}
