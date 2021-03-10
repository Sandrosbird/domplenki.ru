//
//  CatalogueViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 22.01.2021.
//

import UIKit

class CatalogueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    let singleton = Singleton.shared
    var catalogueItems: [ShopItem] = []
    let myRefreshControl = UIRefreshControl()
    let indexPathsArray: [IndexPath] = []
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        configureRefreshControl()
        if singleton.checkCatalogueForEmptiness() {
            singleton.fillCatalogue()
        } else {
            catalogueItems = singleton.getItems(type: .catalogue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = catalogueItems[row]
        let indexPath = IndexPath(item: row, section: 0)
        let favorites = singleton.getItems(type: .favorite)
        
        if favorite.isFavorite {
            singleton.changeItemFlag(type: .favorite, for: favorite)
//            catalogueItems.remove(at: row)
//            catalogueItems.insert(favorite, at: row)
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            singleton.changeItemFlag(type: .favorite, for: favorite)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @IBAction func priceTypeButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let indexPath = IndexPath(item: row, section: 0)
        let item = catalogueItems[row]
        
        singleton.changeItemFlag(type: .priceType, for: item)

        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
