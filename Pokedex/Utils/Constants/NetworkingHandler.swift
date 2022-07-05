//
//  NetworkingHandler.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation

class NetworkingHandler: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        // Indicate network status, e.g., offline mode
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest: URLRequest, completionHandler: (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        // Indicate network status, e.g., back to online
    }
}
