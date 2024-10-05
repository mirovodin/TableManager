//
//  ModuleAlphaViewTableManager.swift
//  TableManager
//
//  Created by Dmitriy Mirovodin on 04.10.2024.
//

import Foundation
import UIKit

final class ModuleAlphaViewTableManager: NSObject {
    
    private weak var tableView: UITableView?
    private var items: [ModuleAlphaTableViewCell.Model]?
    
    var onTapped: ((_ indexPath: IndexPath) -> Void)?
    
    func set(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView
    }
    
    func bind(items: [ModuleAlphaTableViewCell.Model]) {
        self.items = items
        tableView?.reloadData()
    }
}

extension ModuleAlphaViewTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapped?(indexPath)
    }
}

extension ModuleAlphaViewTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        guard let items = items, items.indices.contains(row), let cell = tableView.dequeueReusableCell(withIdentifier: ModuleAlphaTableViewCell.id) as? ModuleAlphaTableViewCell else {
            return UITableViewCell()
        }
        
        let item = items[row]
        
        let cellModel = ModuleAlphaTableViewCell.Model(
            title: item.title,
            value: item.value,
            isChecked: item.isChecked
        )
        cell.update(with: cellModel)
        return cell
    }
}
