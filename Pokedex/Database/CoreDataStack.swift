//
//  CoreDataStack.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
import CoreData

enum StorageType {
  case persistent, inMemory
}

class CoreDataStack {
    
    init() {}
    
    lazy var container: NSPersistentContainer = {
        let tempContainer = NSPersistentContainer(name: "Pokedex")

        tempContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        tempContainer.viewContext.shouldDeleteInaccessibleFaults = true
        
        return tempContainer
    }()
    
}


