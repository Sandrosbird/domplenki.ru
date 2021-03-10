//
//  ViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 20.01.2021.
//

import UIKit

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        // add search protocol
    }
    
    //MARK: - Outlets
    @IBOutlet weak var catalogueActionsCollectionView: UICollectionView!
    @IBOutlet weak var recentItemsCollectionView: UICollectionView!
    @IBOutlet weak var recentsTitleBackgroundView: UIView!
    @IBOutlet weak var recentItemsCollectionViewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    lazy var recents: [ShopItem] = [] {
        didSet {
            self.recentItemsCollectionView.restore()
        }
    }
    lazy var catalogueActions: [String] = ["Каталог","Лучшая цена"]
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogueActionsCollectionView.dataSource = self
        catalogueActionsCollectionView.delegate = self
        recentItemsCollectionView.dataSource = self
        recentItemsCollectionView.delegate = self
       
        
        if Singleton.shared.checkCatalogueForEmptiness() {
            Singleton.shared.fillCatalogue()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setupNavigationBar()
        reloadRecents()
        recents = Singleton.shared.getItems(type: .recent)
        navigationController?.forceUpdateNavigationBar()
        
    }
}

