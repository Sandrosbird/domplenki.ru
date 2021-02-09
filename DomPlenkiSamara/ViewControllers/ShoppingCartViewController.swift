//
//  ShoppingCartViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 23.01.2021.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    
    //MARK: - Properties
    let myRefreshControl = UIRefreshControl()
    let singleton = Singleton.shared
    var shoppingCart: [ShopItem] = Singleton.shared.getItems(type: .cart)
    var averagePrice: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        refreshTable(nil)
        updateAveragePrice()
    }
    
    //MARK: - TableView Delegate&DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopCartCell") as? CatalogueTableViewCell,
            let price = shoppingCart[indexPath.row].price,
            let actionPrice = shoppingCart[indexPath.row].actionPrice
            else { return UITableViewCell() }
        
        cell.cellImage.image = shoppingCart[indexPath.row].image
        cell.cellName.text = shoppingCart[indexPath.row].name
        cell.cellPrice.text = "\(price) ₽/ед."
        cell.countLabel.text = "x \(shoppingCart[indexPath.row].count)"
        if shoppingCart[indexPath.row].isSale == true {
            cell.cellActionPrice.text = "Акция: \(actionPrice) ₽/ед."
        } else {
            cell.cellPrice.textColor = .black
            cell.cellActionPrice.text = nil
        }
        
        if shoppingCart[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailViewController") as? ItemDetailViewController else { return }
        itemDetailViewController.item = shoppingCart[indexPath.row]
        itemDetailViewController.row = indexPath.row
        showDetailViewController(itemDetailViewController, sender: self)
//        show(itemDetailViewController, sender: self)
    }
    
    //MARK: - Helpers
    func configureButton() {
        StyleButtonsFields.styleFilledButton(orderButton)
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
        shoppingCart = Singleton.shared.getItems(type: .cart)
        updateAveragePrice()
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
    
    func updateAveragePrice() {
        averagePrice = 0
        for item in shoppingCart {
            let actionPrice = Int(item.actionPrice!)
            let price = Int(item.price!)
            if item.isSale {
                averagePrice! = averagePrice! + (actionPrice! * item.count)
            } else {
                averagePrice! = averagePrice! + (price! * item.count)
            }
            guard let averagePriceStrong = averagePrice else {
                return
            }
            priceLabel.text = String(averagePriceStrong) + " ₽"
        }
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = shoppingCart[row]
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toOrderViewController" else { return }
        guard
            let destination = segue.destination as? OrderViewController,
            let averagePriceStrong = averagePrice
        else { return }
        destination.totalPrice = String(averagePriceStrong) + " ₽"
    }

}
