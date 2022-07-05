//
//  CoredataManager.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 02/07/22.
//

import CoreData
import UIKit

final class CoredataManager {

    // MARK: - Initialization
    
    let coredatastack: CoreDataStack

    init(coredatastack: CoreDataStack = CoreDataStack()) {
        self.coredatastack = coredatastack
        privateMOC.parent = coredatastack.container.viewContext
    }
    
    
    // MARK: - Private Properties
    
    private let serialQueue = DispatchQueue(label: "CoreDataSerialQueue")
    private let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

    
    // MARK: - Get
    
    func getPokemon(name: String) -> Pokemon? {
        
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let pokemon = try coredatastack.container.viewContext.fetch(request).first
            
            return pokemon
            
        }  catch let error {
            print(error)
        }
        
        return nil
    }

    func getFavoritedPokemon(limit: Int?, completionHandler: @escaping (Result<[Pokemon], NetworkError>) -> Void) {
        
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let predicate = NSPredicate(format: "isFavourite = %d", true)
        request.predicate = predicate
    
        if let limit = limit {
            request.fetchLimit = limit
        }
        
        do {
            let storages = try coredatastack.container.viewContext.fetch(request)
            completionHandler(.success(storages))
            
        }  catch let error {
            completionHandler(.failure(.somethingWentWrong))
        }
    }
    
    // MARK: - Update

    func togglePokemonFavourite(model: PokemonInformationModel)
    {
        privateMOC.performAndWait {
            guard let pokemon = getPokemon(id: model.id) else {
                savePokemon(model: model, image: nil)
                return
                
            }
            
            pokemon.isFavourite = !pokemon.isFavourite

            synchronize()
        }
        
    }
    
    func updatePokemonImage(model: PokemonInformationModel, image: UIImage?)
    {
        privateMOC.performAndWait {
            guard let pokemon = getPokemon(id: model.id) else {
                savePokemon(model: model, image: image)
                return
                
            }
            
            pokemon.image = image?.pngData()

            synchronize()
        }
        
    }
    
    func savePokemon(model: PokemonInformationModel, image: UIImage?)
    {
        privateMOC.performAndWait {
            
            guard let pokemon = createPokemonEntity(model: model, image: image) else { return }
            
            for typeElement in model.typeElements {
                if let typeItem = createPokemonTypeEntity(type: typeElement.type) {
                    typeItem.addToPokemon(pokemon)
                    synchronize()
                }
            }
            
        }

        
    }
    


    // MARK: - private methods
    
    private func createPokemonTypeEntity(type: TypesModel) -> PokemonType? {
        guard let pokemonTypeEntity = NSEntityDescription.entity(forEntityName: "PokemonType", in: coredatastack.container.viewContext), let pokemonTypeItem = NSManagedObject(entity: pokemonTypeEntity, insertInto: coredatastack.container.viewContext) as? PokemonType  else { return nil }
  
        pokemonTypeItem.name = type.name
        pokemonTypeItem.url = type.url
        
        return pokemonTypeItem
    }

    private func createPokemonEntity(model: PokemonInformationModel, image: UIImage?) -> Pokemon? {
        guard let pokemonEntity = NSEntityDescription.entity(forEntityName: "Pokemon", in: coredatastack.container.viewContext), let pokemonItem = NSManagedObject(entity: pokemonEntity, insertInto: coredatastack.container.viewContext) as? Pokemon else { return nil }
        
        pokemonItem.name = model.name
        pokemonItem.id = Int64(model.id)
        pokemonItem.baseExperience = Int64(model.baseExperience)
        pokemonItem.height = Int64(model.height)
        pokemonItem.weight = Int64(model.weight)
        pokemonItem.isFavourite = model.isFavourited
        pokemonItem.image = image?.pngData()
        pokemonItem.imageUrl = model.sprites.other.officialArtwork.url
        
        return pokemonItem
    }
    
    private func getPokemon(id: Int) -> Pokemon? {
        
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let predicate = NSPredicate(format: "id = %d", id)
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let pokemon = try coredatastack.container.viewContext.fetch(request).first
            
            return pokemon
            
        }  catch let error {
            print(error)
        }
        
        return nil
    }
    
    private func synchronize() {
        do {
            try self.privateMOC.save()
            coredatastack.container.viewContext.performAndWait {
                do {
                    try coredatastack.container.viewContext.save()
                } catch {
                    print("Could not synchonize data. \(error), \(error.localizedDescription)")
                }
            }
        } catch {
            print("Could not synchonize data. \(error), \(error.localizedDescription)")
        }
    }

}
