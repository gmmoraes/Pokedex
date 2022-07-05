//
//  PokemonTableDataAdapter.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation


final class PokemonTableDataAdapter {
    
    private let model: PokemonInformationModel
    
    struct Constants {
        static let name = "Name"
        static let height = "Height"
        static let weight = "Weight"
        static let baseExperience = "Base experience"
        static let id = "ID"
    }

    init(model:PokemonInformationModel) {
        self.model = model
    }
    
    func createTableDataSource(model: PokemonInformationModel) -> [PokemonTableDatasource] {
        var datasources: [PokemonTableDatasource] = []
        
        let nameData = PokemonTableDatasource(keyConstant: Constants.name, valueContants: model.name.firstUppercased)
        let heightData = PokemonTableDatasource(keyConstant: Constants.height, valueContants:  String(format: "%d dm", model.height))
        let weightData = PokemonTableDatasource(keyConstant: Constants.weight, valueContants:  String(format: "%d hg", model.weight))
        let baseExperienceData = PokemonTableDatasource(keyConstant: Constants.baseExperience, valueContants: String(model.baseExperience))
        let iData = PokemonTableDatasource(keyConstant: Constants.id, valueContants:  String(format: "#%d", model.id))
        
        datasources.append(nameData)
        datasources.append(heightData)
        datasources.append(weightData)
        datasources.append(baseExperienceData)
        datasources.append(iData)
        
        
        return datasources
    }
}
