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
        if singleton.catalogueItems.isEmpty {
            catalogueItems = ItemsFactory.createItems()
            singleton.catalogueItems = catalogueItems
        } else {
            catalogueItems = singleton.catalogueItems
        }
        
    }
    
    //MARK: - Delegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalogueItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "catalogueCell") as? CatalogueTableViewCell,
            let price = catalogueItems[indexPath.row].price,
            let actionPrice = catalogueItems[indexPath.row].actionPrice
        else { return UITableViewCell() }
        cell.cellName.text = catalogueItems[indexPath.row].name
        cell.cellPrice.text = "Цена: \(price) ₽/ед."
        cell.cellImage.image = catalogueItems[indexPath.row].image

        cell.favoriteButton.tag = indexPath.row
        
        if catalogueItems[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        
        return cell
    }
    
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
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailViewController") as? ItemDetailViewController else { return }
        itemDetailViewController.item = catalogueItems[indexPath.row]
        itemDetailViewController.row = indexPath.row
        showDetailViewController(itemDetailViewController, sender: self)
//        show(itemDetailViewController, sender: self)
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = catalogueItems[row]
        let indexPath = IndexPath(item: row, section: 0)
        let favorites = singleton.getItems(type: .favorite)
        
        if !favorites.contains(favorite) {
            favorite.isFavorite = true
            singleton.catalogueItems[row].isFavorite = true
            catalogueItems.remove(at: row)
            catalogueItems.insert(favorite, at: row)
            singleton.recordItem(type: .favorite, item: favorite)
            
            tableView.reloadRows(at: [indexPath], with: .left)
            
        } else {
            favorite.isFavorite = false
            singleton.catalogueItems[row].isFavorite = false
            singleton.removeItem(type: .favorite, position: row)
            tableView.reloadRows(at: [indexPath], with: .left)
            
        }
    }
}
