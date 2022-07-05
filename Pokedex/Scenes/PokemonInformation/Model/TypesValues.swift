//
//  TypesValues.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

enum TypesValues: String, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy

    
    // Cores
    // https://s3.amazonaws.com/arena-attachments/2578621/b56e5c76f2f8f3254a0c41c1221f8ef5.pdf?1534796623
    func getMainColor() -> UIColor {
        switch self {
        case .normal:
            return #colorLiteral(red: 0.8470588235, green: 0.7450980392, blue: 0.6352941176, alpha: 1)
        case .fighting:
            return #colorLiteral(red: 0.8549019608, green: 0.262745098, blue: 0.3450980392, alpha: 1)
        case .flying:
            return #colorLiteral(red: 0.6274509804, green: 0.7333333333, blue: 0.9098039216, alpha: 1)
        case .poison:
            return #colorLiteral(red: 0.7647058824, green: 0.3764705882, blue: 0.8352941176, alpha: 1)
        case .ground:
            return #colorLiteral(red: 0.831372549, green: 0.5882352941, blue: 0.4117647059, alpha: 1)
        case .rock:
            return #colorLiteral(red: 0.7843137255, green: 0.7254901961, blue: 0.5411764706, alpha: 1)
        case .bug:
            return #colorLiteral(red: 0.6392156863, green: 0.7764705882, blue: 0.1921568627, alpha: 1)
        case .ghost:
            return #colorLiteral(red: 0.3333333333, green: 0.4196078431, blue: 0.6823529412, alpha: 1)
        case .steel:
            return #colorLiteral(red: 0.337254902, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        case .fire:
            return #colorLiteral(red: 0.9803921569, green: 0.6509803922, blue: 0.3019607843, alpha: 1)
        case .water:
            return #colorLiteral(red: 0.4235294118, green: 0.737254902, blue: 0.8862745098, alpha: 1)
        case .grass:
            return #colorLiteral(red: 0.3568627451, green: 0.7529411765, blue: 0.4588235294, alpha: 1)
        case .electric:
            return #colorLiteral(red: 0.9725490196, green: 0.8666666667, blue: 0.3960784314, alpha: 1)
        case .psychic:
            return #colorLiteral(red: 0.9921568627, green: 0.6274509804, blue: 0.6, alpha: 1)
        case .ice:
            return #colorLiteral(red: 0.5529411765, green: 0.8549019608, blue: 0.8235294118, alpha: 1)
        case .dragon:
            return #colorLiteral(red: 0.09019607843, green: 0.4980392157, blue: 0.737254902, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.4352941176, green: 0.4666666667, blue: 0.5215686275, alpha: 1)
        case .fairy:
            return #colorLiteral(red: 0.9411764706, green: 0.631372549, blue: 0.8901960784, alpha: 1)
        }
        
    }
    
    func getSubColor() -> UIColor {
        switch self {
        case .normal:
            return #colorLiteral(red: 0.9019607843, green: 0.831372549, blue: 0.631372549, alpha: 1)
        case .fighting:
            return #colorLiteral(red: 0.9019607843, green: 0.4039215686, blue: 0.2352941176, alpha: 1)
        case .flying:
            return #colorLiteral(red: 0.6666666667, green: 0.6156862745, blue: 0.9607843137, alpha: 1)
        case .poison:
            return #colorLiteral(red: 0.8901960784, green: 0.3568627451, blue: 0.5019607843, alpha: 1)
        case .ground:
            return #colorLiteral(red: 0.8784313725, green: 0.7215686275, blue: 0.3960784314, alpha: 1)
        case .rock:
            return #colorLiteral(red: 0.7843137255, green: 0.7254901961, blue: 0.5411764706, alpha: 1)
        case .bug:
            return #colorLiteral(red: 0.2117647059, green: 0.831372549, blue: 0.1647058824, alpha: 1)
        case .ghost:
            return #colorLiteral(red: 0.4392156863, green: 0.3215686275, blue: 0.7294117647, alpha: 1)
        case .steel:
            return #colorLiteral(red: 0.3254901961, green: 0.4901960784, blue: 0.7098039216, alpha: 1)
        case .fire:
            return #colorLiteral(red: 0.9921568627, green: 0.8, blue: 0.2588235294, alpha: 1)
        case .water:
            return #colorLiteral(red: 0.4039215686, green: 0.4901960784, blue: 0.9411764706, alpha: 1)
        case .grass:
            return #colorLiteral(red: 0.337254902, green: 0.8, blue: 0.7137254902, alpha: 1)
        case .electric:
            return #colorLiteral(red: 0.9450980392, green: 0.9882352941, blue: 0.3568627451, alpha: 1)
        case .psychic:
            return #colorLiteral(red: 0.9960784314, green: 0.7098039216, blue: 0.5490196078, alpha: 1)
        case .ice:
            return #colorLiteral(red: 0.5411764706, green: 0.7450980392, blue: 0.9019607843, alpha: 1)
        case .dragon:
            return #colorLiteral(red: 0.09019607843, green: 0.4980392157, blue: 0.737254902, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.4666666667, green: 0.4431372549, blue: 0.568627451, alpha: 1)
        case .fairy:
            return #colorLiteral(red: 0.9725490196, green: 0.6196078431, blue: 0.6039215686, alpha: 1)
        }
        
    }

}

