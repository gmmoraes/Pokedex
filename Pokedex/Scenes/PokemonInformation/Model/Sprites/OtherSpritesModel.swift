//
//  OtherSpritesModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation


struct OtherSpritesModel: Codable {
    let officialArtwork: OfficialArtworkModel
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
