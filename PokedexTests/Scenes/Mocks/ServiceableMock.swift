//
//  ServiceableMock.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
@testable import Pokedex

class ServiceableMock<T: Codable>: NSObject, Serviceable {

    private var dataTasks : [URLSessionDataTask] = []
    private let fileName:String
    private var resultType: T.Type

    
    init(fileName: String, resultType: T.Type) {
        self.fileName = fileName
        self.resultType = resultType
        super.init()
    }

    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        if dataTasks.firstIndex(where: { task in
            task.originalRequest?.url == url
        }) != nil {
            return
        }
        
        if let jsonData = getJsonFromFile(fileName: fileName) {
            let result = parseJson(data: jsonData)
            completionHandler(.success(result))
        } else {
            completionHandler(.failure(.somethingWentWrong))
        }
        
    }

    
    
    private func getJsonFromFile(fileName: String) -> Data? {

        do {
            if let file = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
                guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)) else {return nil}
                return data
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func parseJson(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("JSON decode error:", error)
            return nil
        }
    }
    
}
