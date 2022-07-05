//
//  TestCoreDataStack.swift
//  PokedexTests
//
//  Created by Gabriel Moraes on 04/07/22.
//

import Foundation
import CoreData
import XCTest
@testable import Pokedex


class TestCoreDataStack:CoreDataStack {

    lazy var _persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pokedex")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        description.url = URL(fileURLWithPath: "/dev/null")
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
                                        
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        container.viewContext.shouldDeleteInaccessibleFaults = true

        return container
    }()
    
    
    override var container: NSPersistentContainer {
      get { return _persistentContainer }
      set { _persistentContainer = newValue }
    }
    
}
