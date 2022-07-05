//
//  XCUIElement+scrollToElement.swift
//  PokedexUITests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
import XCTest

extension XCUIElement {
    
    func scrollToElement(element: XCUIElement, limitScrolls: Int) {
        var currentLimit = 0
        
        while (!element.visible()) && currentLimit <  limitScrolls {
            currentLimit += 1
            swipeUp()
            sleep(1)
        }
    }
    
    func visible() -> Bool {
        guard self.exists && self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
