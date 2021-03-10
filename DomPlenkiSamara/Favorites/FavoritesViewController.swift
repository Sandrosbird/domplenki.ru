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
    var favorites: [ShopItem] = []
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = singleton.getItems(type: .favorite)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        refreshTable(nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.isEmpty {
            self.tableView.setEmptyMessage("Вы пока не добавили товары в избранное")
        } else {
            self.tableView.restore()
        }
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = favorites[indexPath.row]
        let flag = item.priceTypeFlag
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell") as? CatalogueTableViewCell,
            let price = item.price1,
            let secondPrice = item.price2,
            let thirdPrice = item.price3,
            let fourthPrice = item.price4
            else { return UITableViewCell() }
        cell.cellImage.image = favorites[indexPath.row].image
        cell.cellName.text = favorites[indexPath.row].name
        
        cell.priceTypeButton.tag = indexPath.row
        
        if flag {
            StyleButtonsFields.styleHollowButton(cell.priceTypeButton)
            cell.cellPrice.text = "Розн.: \(price)"
            cell.cellActionPrice.text = "Опт.: \(secondPrice)"
            
            cell.priceTypeButton.setTitle("₽/п.м", for: .normal)
        } else {
            StyleButtonsFields.styleFilledButton(cell.priceTypeButton)
            cell.cellPrice.text = "Розн.: \(thirdPrice)"
            cell.cellActionPrice.text = "Опт.: \(fourthPrice)"
            
            cell.priceTypeButton.setTitle("₽/кв.м", for: .normal)
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
            singleton.changeItemFlag(type: .favorite, for: favorites[indexPath.row])
            favorites = singleton.getItems(type: .favorite)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return }
        itemDetailViewController.item = favorites[indexPath.row]
        itemDetailViewController.row = indexPath.row
//        showDetailViewController(itemDetailViewController, sender: self)
        show(itemDetailViewController, sender: self)
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
    
    func setupNavigationBar() {
        navigationItem.title = "Избранное"
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = favorites[row]
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
        let item = favorites[row]
        
        singleton.changeItemFlag(type: .priceType, for: item)

        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
