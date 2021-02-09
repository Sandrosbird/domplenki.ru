//
//  ActionsViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 25.01.2021.
//

import UIKit

class ActionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let singleton = Singleton.shared
    let myRefreshControl = UIRefreshControl()
    var catalogueItems: [ShopItem] = []
    var actionItems: [ShopItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        fillActionItems()
        configureTableView()
    }
    

    //MARK: - TableView Delegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "actionsCell") as? CatalogueTableViewCell,
            let price = actionItems[indexPath.row].price,
            let actionPrice = actionItems[indexPath.row].actionPrice
            else { return UITableViewCell() }
        
        cell.cellImage.image = actionItems[indexPath.row].image
        cell.cellName.text = actionItems[indexPath.row].name
        cell.cellPrice.text = "Цена: \(price) ₽/ед."
        cell.cellActionPrice.text = "Акция: \(actionPrice) ₽/ед."
        cell.favoriteButton.tag = indexPath.row
        
        if actionItems[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        return cell
    }
    
    //MARK: - Helpers
    func fillActionItems() {
        if singleton.catalogueItems.isEmpty {
            catalogueItems = ItemsFactory.createItems()
            singleton.catalogueItems = catalogueItems
            for item in catalogueItems {
                if item.isSale == true {
                    actionItems.append(item)
                }
            }
        } else {
            catalogueItems = singleton.catalogueItems
            for item in catalogueItems {
                if item.isSale == true {
                    actionItems.append(item)
                }
            }
        }
    }
    
    func configureTableView() {
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
        actionItems = []
        fillActionItems()
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailViewController") as? ItemDetailViewController else { return }
        itemDetailViewController.item = actionItems[indexPath.row]
        showDetailViewController(itemDetailViewController, sender: self)
//        show(itemDetailViewController, sender: self)
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = actionItems[row]
        let indexPath = IndexPath(item: row, section: 0)
        let favorites = singleton.getItems(type: .favorite)
        if !favorites.contains(favorite) {
            favorite.isFavorite = true
            actionItems.remove(at: row)
            actionItems.insert(favorite, at: row)
            singleton.recordItem(type: .favorite, item: favorite)
            tableView.reloadRows(at: [indexPath], with: .left)
//            tableView.reloadData()
        } else {
            favorite.isFavorite = false
            singleton.removeItem(type: .favorite, position: row)
            tableView.reloadRows(at: [indexPath], with: .left)
//            tableView.reloadData()
        }
    }
}
