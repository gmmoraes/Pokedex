//
//  PokemonService.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import Foundation

class PokemonService<T: Codable>: NSObject, Serviceable, URLSessionDelegate {
    
    private var dataTasks : [URLSessionDataTask] = []
    private var resultType: T.Type
    
    // MARK: - Init
    
    init(resultType: T.Type) {
        self.resultType = resultType
        super.init()
    }
    
    // MARK: - Methods

    func fetchOne(from urlString: String, completionHandler: @escaping (Result<Codable, NetworkError>) -> Void) {

        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 10
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        if dataTasks.firstIndex(where: { task in
            task.originalRequest?.url == url
        }) != nil {
            return
        }
        
        let dataTask = session.dataTask(with: url) { [weak self] (data, urlResponse, error) in
            if let data = data, let result = self?.parseJson(data: data)  {
                completionHandler(.success(result))
            } else if error != nil {
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        
        dataTask.resume()
        dataTasks.append(dataTask)
    }
    
    // MARK: - Private Methods
    
    private func parseJson(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("JSON decode error:", error)
            return nil
        }
    }
    
}
