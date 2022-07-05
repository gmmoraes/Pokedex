//
//  ServiceableDummy.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
@testable import Pokedex

class ServiceableDummy: NSObject, Serviceable {
    
    private var dataTasks : [URLSessionDataTask] = []
    
    struct CodableDummy: Codable {}
    
    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void) {
        completionHandler(.success(CodableDummy()))
    }
    
}
