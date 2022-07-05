//
//  OfficialArtworkModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation

struct OfficialArtworkModel: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}
