//
//  SpritesModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

struct SpritesModel: Codable {

    var image: UIImage?
    let other: OtherSpritesModel
    
    enum CodingKeys: String, CodingKey {
        case other
    }
}
