//
//  PokemonModelAdapter.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import CoreData
import UIKit

final class PokemonModelAdapter {

    func createModels(datas: [Pokemon]) -> [PokemonInformationModel]  {
        var models: [PokemonInformationModel] = []
        
        for data in datas {
            let model = createModel(data: data)
            models.append(model)
        }
        
        return models
    }
    
    func createModel(data: Pokemon) -> PokemonInformationModel {
        let id = Int(data.id)
        let baseExperience = Int(data.baseExperience)
        let height = Int(data.height)
        let weight = Int(data.weight)
        let types = createTypesModel(data: data)
        let sprites = createSprites(data: data)
        
        return PokemonInformationModel(baseExperience: baseExperience, height: height, id: id, name: data.name ?? "", typeElements: types, sprites: sprites, weight: weight, isFavourited: data.isFavourite)
    }
    
    // MARK: - Private Methods

    private func createTypesModel(data: Pokemon) -> [TypeElement] {
        var elements: [TypeElement] = []
        guard let types = data.type?.array as? [PokemonType]  else { return elements }
        
        for type in types {
            let typeModel = TypesModel(name: type.name ?? "" , url: type.url ?? "")
            let element = TypeElement(slot: 0, type: typeModel)
            elements.append(element)
        }
        
        return elements
    }
    
    private func createSprites(data: Pokemon) -> SpritesModel {
        let artwork = OfficialArtworkModel(url: data.imageUrl ?? "")
        let otherSpritesModel = OtherSpritesModel(officialArtwork: artwork)
        var sprites = SpritesModel(other: otherSpritesModel)
        
        if let dataImage = data.image {
            sprites.image = UIImage(data: dataImage)
        }

        return sprites
    }
}
