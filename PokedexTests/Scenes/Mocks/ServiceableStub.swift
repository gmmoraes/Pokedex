//
//  ServiceableStub.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
@testable import Pokedex

class ServiceableStub: NSObject, Serviceable {

    let pokemonName = "bulbasaur"

    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void) {
        let model = createModel()
        completionHandler(.success(model))
    }
    
    private func createModel() -> PokemonInformationModel {
        let typesModel = TypesModel(name: "", url: "")
        let types = TypeElement(slot: 0, type: typesModel)
        let model = PokemonInformationModel(baseExperience: 0, height: 1, id: 1, name: pokemonName, typeElements: [types], sprites: SpritesModel(other: OtherSpritesModel(officialArtwork: OfficialArtworkModel(url: ""))), weight: 1, isFavourited: true)
        return model
    }
    
}
