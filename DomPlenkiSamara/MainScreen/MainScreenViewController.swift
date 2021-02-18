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
    @IBOutlet weak var catalogueActionsCollectionVIew: UICollectionView!
    @IBOutlet weak var recentItemsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recentsTitleBackgroundView: UIView!
    
    
    //MARK: - Variables
    lazy var recents: [ShopItem] = []
    
    lazy var catalogueActions: [String] = ["Каталог","Акции"]
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogueActionsCollectionVIew.dataSource = self
        catalogueActionsCollectionVIew.delegate = self
        recentItemsCollectionView.dataSource = self
        recentItemsCollectionView.delegate = self
        
        if Singleton.shared.checkCatalogueForEmptiness() {
            Singleton.shared.fillCatalogue()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        configureViewHeight()
        
        recents = Singleton.shared.getItems(type: .recent)
        recentItemsCollectionView.reloadData()
    }

    //MARK: - Delegate&DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == catalogueActionsCollectionVIew) {
            return 2
        }
        
        return recents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalogueActionsCollectionVIew {
            guard let catalogueActionsCell = catalogueActionsCollectionVIew.dequeueReusableCell(withReuseIdentifier: "catalogueActionsCell", for: indexPath) as? CatalogueActionCollectionViewCell else { return UICollectionViewCell() }
            
            catalogueActionsCell.cellNameLabel.text = catalogueActions[indexPath.row]
            switch indexPath.row {
            case 0:
                catalogueActionsCell.cellImage.image = UIImage(named: "list.dash")
                catalogueActionsCell.cellImage.highlightedImage = UIImage(named: "list.dash")
            default:
                catalogueActionsCell.cellImage.image = UIImage(named: "percent")
                catalogueActionsCell.cellImage.highlightedImage = UIImage(named: "percent")
            }
            catalogueActionsCell.backgroundColor = UIColor.blue
            catalogueActionsCell.layer.cornerRadius = 5
            catalogueActionsCell.layer.masksToBounds = true
            
            return catalogueActionsCell
        } else if collectionView == recentItemsCollectionView {
            guard
                let recentItemsCell = recentItemsCollectionView.dequeueReusableCell(withReuseIdentifier: "recentItemsCell", for: indexPath) as? RecentItemsCollectionViewCell,
                let price = recents[indexPath.row].price,
                let actionPrice = recents[indexPath.row].actionPrice
            else { return UICollectionViewCell() }
            recentItemsCell.cellNameLabel.text = recents[indexPath.row].name
            recentItemsCell.cellPriceLabel.text = "\(price) ₽/ед."
            if recents[indexPath.row].isSale == true {
                recentItemsCell.cellActionPriceLabel.text = "Акция: \(actionPrice) ₽/ед."
            } else {
                recentItemsCell.cellPriceLabel.textColor = .black
                recentItemsCell.cellActionPriceLabel.text = nil
            }
            
            recentItemsCell.cellImage.image = recents[indexPath.row].image
            return recentItemsCell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView == catalogueActionsCollectionVIew {
            if indexPath.row == 0 {
                performSegue(withIdentifier: "toCatalogue", sender: nil)
            } else {
                performSegue(withIdentifier: "toActions", sender: nil)
            }
        } else if collectionView == recentItemsCollectionView {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return true }
            itemDetailViewController.item = recents[indexPath.row]
            itemDetailViewController.row = indexPath.row
//            showDetailViewController(itemDetailViewController, sender: self)
            show(itemDetailViewController, sender: self)
        }
        
        return true
    }
    
    func setupNavigationBar() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchBar.isTranslucent = false
        StyleButtonsFields.styleSearchTextField(searchBar.searchTextField)
        searchBar.searchTextField.tintColor = .white
        searchBar.tintColor = .white
        searchBar.placeholder = "Поиск по каталогу"
        
//        searchController.hidesNavigationBarDuringPresentation = true
//        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
//        searchController.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .blue
            textField.backgroundColor = .white
        }
        
        navigationItem.title = "Главная"
        
        navigationController?.navigationBar.barStyle = .default
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
    }
    
    func configureViewHeight() {
        guard let navigationBarHeight = self.navigationController?.navigationBar.frame.height else { return }
        let estimateHeight = recentItemsCollectionView.frame.height + catalogueActionsCollectionVIew.frame.height + recentsTitleBackgroundView.frame.height + navigationBarHeight
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: estimateHeight)
    }
    
    //MARK: - Actions
    
}

