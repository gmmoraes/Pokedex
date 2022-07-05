//
//  Serviceable.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import Foundation

protocol Serviceable {
    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void)
}
    
extension Serviceable {
    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void)  {
        // Optional
    }
}
