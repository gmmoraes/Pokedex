//
//  TypesModel.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypesModel
}

// MARK: - TypeType
struct TypesModel: Codable {
    let name: String
    let url: String
    //var order: Int64
}
