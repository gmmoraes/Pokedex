//
//  PokemonInformationModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation
import UIKit

struct PokemonInformationModel: Codable {
    let baseExperience: Int
    let height: Int
    let id: Int
    let name: String
    let typeElements: [TypeElement]
    let sprites: SpritesModel
    let weight: Int
    var isFavourited: Bool = false

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case id
        case name
        case typeElements = "types"
        case sprites , weight
    }
}
