//
//  ViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 20.01.2021.
//

import UIKit

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catalogueActionsCollectionVIew: UICollectionView!
    @IBOutlet weak var recentItemsCollectionView: UICollectionView!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    
    //MARK: - Variables
    
    var recents: [ShopItem] {
        let wholeCatalogue = Singleton.shared.catalogueItems
        var recents: [ShopItem] = []
        for item in wholeCatalogue {
            if item.isRecent {
                recents.append(item)
            }
        }
        return recents
    }
    
    var catalogueActions: [String] = ["Каталог","Акции"]
    
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        catalogueActionsCollectionVIew.dataSource = self
        catalogueActionsCollectionVIew.delegate = self
        recentItemsCollectionView.dataSource = self
        recentItemsCollectionView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.blue.cgColor
        var searchBarTextField = searchBar.value(forKey: "searchField") as? UITextField
        
        searchBarTextField?.textColor = .black
        searchBarTextField?.backgroundColor = .white
        searchBar.tintColor = .blue
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
            recentItemsCell.cellPriceLabel.text = "Цена: \(price) ₽/ед."
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
            guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailViewController") as? ItemDetailViewController else { return true }
            itemDetailViewController.item = recents[indexPath.row]
            itemDetailViewController.row = indexPath.row
            showDetailViewController(itemDetailViewController, sender: self)
//            show(itemDetailViewController, sender: self)
        }
        
        return true
    }
    
    
    //MARK: - Actions
    
}

