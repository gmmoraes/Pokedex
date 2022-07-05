//
//  String+Uppercase.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
