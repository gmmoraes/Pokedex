//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import Foundation

protocol PokemonListViewModelProtocol {
    var pokemonList: [PokemonListModel] { get }

    func preFetchData(indexPath: IndexPath, completionHandler: @escaping (Result<Void, NetworkError>) -> Void)
    func fetchData(completionHandler: @escaping (Result<[PokemonListModel], NetworkError>) -> Void)
}


final class PokemonListViewModel {
    
    
    // MARK: - Private properties

    private var currentOffset = 0
    private var service: Serviceable
    
    // MARK: Properties
    
    var pokemonList: [PokemonListModel] = []
    let cellReuseIdentifier = "PokemonListViewCell"

    // MARK: - Init
    
    init(service: Serviceable = PokemonService(resultType: PokemonListResults.self)) {
        self.service = service
    }
    
    private func fetchOne(completionHandler: @escaping (Result<Codable, NetworkError>) -> Void) {
        let urlStr = String(format: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=%d", currentOffset)
        service.fetchOne(from: urlStr,completionHandler: completionHandler)
    }

}

extension PokemonListViewModel: PokemonListViewModelProtocol {
    
    func preFetchData(indexPath: IndexPath, completionHandler: @escaping (Result<(Void), NetworkError>) -> Void) {
        if indexPath.row < pokemonList.count - 10 {
            return
        }
        fetchOne() { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data as? PokemonListResults {
                    self?.currentOffset += 20
                    self?.pokemonList.append(contentsOf: data.results )
                    completionHandler(.success(()))
                } else {
                    completionHandler(.failure(.somethingWentWrong))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func fetchData(completionHandler: @escaping (Result<[PokemonListModel], NetworkError>) -> Void) {
        fetchOne() { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data as? PokemonListResults {
                    let result = data.results
                    self?.currentOffset += 20
                    self?.pokemonList = result
                    completionHandler(.success(result))
                } else {
                    completionHandler(.failure(.somethingWentWrong))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
