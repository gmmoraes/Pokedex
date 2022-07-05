//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

struct PokemonListResults: Codable {
    let results: [PokemonListModel]
}

struct PokemonListModel: Codable {
    let name: String
    let urlStr: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case urlStr = "url"
    }
}
