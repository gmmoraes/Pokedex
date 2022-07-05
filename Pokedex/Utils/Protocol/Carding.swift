//
//  Carding.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

protocol Carding {

    var shadowOffsetWidth: Int? { get }
    var cornerRadius: CGFloat? { get }
    var shadowColor: UIColor? { get }
    var shadowOffsetHeight: Int? { get }
    var shadowOpacity: Float? { get }
    var maskedCorners: CACornerMask? { get }
    var masksToBounds: Bool { get }

}
