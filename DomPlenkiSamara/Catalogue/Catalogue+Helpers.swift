//
//  Catalogue+Helpers.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 19.02.2021.
//

import UIKit

extension CatalogueViewController {
    //MARK: - Helpers
    func configureRefreshControl() {
        
        myRefreshControl.attributedTitle = NSAttributedString(string: "Обновление данных...")
        myRefreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func refreshTable(_ sender: Any?) {
        // TODO: add some mothod to upload fresh data
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.largeTitleDisplayMode = .never
    }
}
