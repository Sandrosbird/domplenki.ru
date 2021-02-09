//
//  FavoritesViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.01.2021.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    let singleton = Singleton.shared
    var favorites: [ShopItem] = Singleton.shared.getItems(type: .favorite)
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        refreshTable(nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell") as? CatalogueTableViewCell,
            let price = favorites[indexPath.row].price,
            let actionPrice = favorites[indexPath.row].actionPrice
            else { return UITableViewCell() }
        cell.cellImage.image = favorites[indexPath.row].image
        cell.cellName.text = favorites[indexPath.row].name
        cell.cellPrice.text = "Цена: \(price) ₽/ед."
        if favorites[indexPath.row].isSale == true {
            cell.cellActionPrice.text = "Акция: \(actionPrice) ₽/ед."
        } else {
            cell.cellPrice.textColor = .black
            cell.cellActionPrice.text = nil
        }
        
        if favorites[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        
        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites[indexPath.row].isFavorite = false
            Singleton.shared.removeItem(type: .favorite, position: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailViewController") as? ItemDetailViewController else { return }
        itemDetailViewController.item = favorites[indexPath.row]
        itemDetailViewController.row = indexPath.row
        showDetailViewController(itemDetailViewController, sender: self)
//        show(itemDetailViewController, sender: self)
    }
    
    
    //MARK: - Helpers
    func configureTableView() {
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        
        myRefreshControl.attributedTitle = NSAttributedString(string: "Обновление данных...")
        myRefreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func refreshTable(_ sender: Any?) {
        favorites = Singleton.shared.getItems(type: .favorite)
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = favorites[row]
        let indexPath = IndexPath(item: row, section: 0)
        let favorites = singleton.getItems(type: .favorite)
        
        if !favorites.contains(favorite) {
            favorite.isFavorite = true
            singleton.catalogueItems[row].isFavorite = true
            
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
