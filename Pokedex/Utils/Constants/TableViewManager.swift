//
//  TableViewManager.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 30/06/22.
//

import UIKit

final class TableViewManager<Model>: NSObject, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    // MARK: - Clousures

    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    var selectedRow: ((Int) -> Void)?
    var prefetchRowsAt: (([IndexPath]) -> Void)?
    
    // MARK: - Properties
    
    var models: [Model] = []

    // MARK: Private properties

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    // MARK: Init

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }


    // MARK: Tableview Delegate and Datasource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.tag = indexPath.row
        cellConfigurator(model, cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow?(indexPath.row)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchRowsAt?(indexPaths)
    }

}
