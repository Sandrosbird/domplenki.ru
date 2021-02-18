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
    var saleItems: [ShopItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        saleItems = singleton.getItems(type: .action)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    //MARK: - TableView Delegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "actionsCell") as? CatalogueTableViewCell,
            let price = saleItems[indexPath.row].price,
            let actionPrice = saleItems[indexPath.row].actionPrice
            else { return UITableViewCell() }
        
        cell.cellImage.image = saleItems[indexPath.row].image
        cell.cellName.text = saleItems[indexPath.row].name
        cell.cellPrice.text = "\(price) ₽/ед."
        cell.cellActionPrice.text = "Акция: \(actionPrice) ₽/ед."
        cell.favoriteButton.tag = indexPath.row
        
        if saleItems[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        return cell
    }
    
    //MARK: - Helpers    
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
        saleItems = []
        saleItems = singleton.getItems(type: .action)
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.largeTitleDisplayMode = .automatic
    }
    

    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return }
        itemDetailViewController.item = saleItems[indexPath.row]
//        showDetailViewController(itemDetailViewController, sender: self)
        show(itemDetailViewController, sender: self)
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = saleItems[row]
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
}
