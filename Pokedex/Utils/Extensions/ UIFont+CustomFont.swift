//
//   UIFont+CustomFont.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

extension UIFont {
    enum FontType {
        
        enum Montserrat: String {
            case regular = ""
            case kFontBlackItalic = "Montserrat-BlackItalic"
            case kFontExtraBoldItalic = "Montserrat-ExtraBoldItalic"
            case kFontBoldItalic = "Montserrat-BoldItalic"
            case kFontSemiBoldItalic = "Montserrat-SemiBoldItalic"
            case kFontMediumItalic = "Montserrat-MediumItalic"
            case kFontItalic = "Montserrat-Italic"
            case kFontLightItalic = "Montserrat-LightItalic"
            case kFontBlack = "Montserrat-Black"
            case kFontExtraLightItalic = "Montserrat-ExtraLightItalic"
            case kFontThinItalic = "Montserrat-ThinItalic"
            case kFontExtraBold = "Montserrat-ExtraBold"
            case kFontBold = "Montserrat-Bold"
            case kFontSemiBold = "Montserrat-SemiBold"
            case kFontMedium = "Montserrat-Medium"
            case kFontRegular = "Montserrat-Regular"
            case kFontLight = "Montserrat-Light"
            case kFontExtraLight = "Montserrat-ExtraLight"
            case kFontThin = "Montserrat-Thin"
            case kPotanoRegular = "PontanoSans-Regular"
        }

        
    }
    
    static func setFont(_ type: String, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type, size: size)!
    }
}


