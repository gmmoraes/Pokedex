//
//  NetworkError.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case somethingWentWrong
    
    func getTitle() -> String {
        switch self {
        case .badURL:
            return "Bard Url"
        case .somethingWentWrong:
            return "Something Went Wrong"
        }
    }
}
