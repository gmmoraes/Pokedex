//
//  PokemonTableDataView.swift
//  Pokedex
//
//  Created by Gabriel Moraes on 01/07/22.
//

import UIKit

class PokemonTableDataView: UIView {
    
    // MARK: - Properties
    
    private let cellReuseIdentifier = "PokemonDataViewCell"
    private var tableViewManager: TableViewManager<PokemonTableDatasource>? {
        didSet {
            if tableViewManager != nil {
                DispatchQueue.main.async {
                    self.applyViewCode()
                }
            }
        }
    }
    
    // MARK: - UI
    
    private(set) lazy var titleLbl: TitleLabel = {
        let titleLabelDatasource = TitleLabelDatasource(title: "Data:", shouldBeAcessible: true)
        let tempLabel = TitleLabel(datasource: titleLabelDatasource)

        return tempLabel
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(PokemonDataViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - private properties

    private var datasource: PokemonInformationModel
    private var timer = Timer()

    

    // MARK: - Init

    init(datasource: PokemonInformationModel) {
        self.datasource = datasource
        super.init(frame: CGRect.zero)
        let adapter = PokemonTableDataAdapter(model: datasource)
        let tableViewDatasource = adapter.createTableDataSource(model: datasource)
        tableviewDataDidLoad(tableViewDatasource)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 10, height:  10))

        let maskLayer = CAShapeLayer()

        layer.masksToBounds = true
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

    
    // MARK: - private methods

    
    private func tableviewDataDidLoad(_ models: [PokemonTableDatasource]) {
        let manager = TableViewManager(
            models: models,
            reuseIdentifier: cellReuseIdentifier
        ) { datasource, cell in
            guard let cell = cell as? PokemonDataViewCell else { return }
            cell.updateData(datasource: datasource)
        }

    //        // We also need to keep a strong reference to the data source,
    //        // since UITableView only uses a weak reference for it.
        tableViewManager = manager
    }


}

extension PokemonTableDataView: ViewCodable {

    func buildHierarchy() {
        addSubview(titleLbl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    func configureViews() {
        backgroundColor =  .clear
    }
    
}

