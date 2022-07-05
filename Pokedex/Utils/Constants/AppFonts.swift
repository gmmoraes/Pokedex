//
//  AppFonts.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

final class AppFonts {
    
    static func titleFont(size: CGFloat = 24) -> UIFont {
        UIFont(name: UIFont.FontType.Montserrat.kFontSemiBold.rawValue, size: size)!
    }
    
    static func subTitleFont(size: CGFloat = 18) -> UIFont {
        UIFont(name: UIFont.FontType.Montserrat.kFontLight.rawValue, size: size)!
    }

}
