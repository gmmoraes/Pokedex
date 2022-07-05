//
//  CollectionViewManager.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

final class CollectionViewManager<Model>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Clousures

    typealias CellConfigurator = (Model, UICollectionViewCell) -> Void
    var selectedRow: ((Int) -> Void)?
    var prefetchRowsAt: (([IndexPath]) -> Void)?

    // MARK: - Properties

    var models: [Model] = []
    
    // MARK: - Private Properties

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    // MARK: - Init

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    // MARK: - Collectionview Datasource and Delegate methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchRowsAt?(indexPaths)
    }
}

