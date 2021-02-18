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
    lazy var shoppingCart: [ShopItem] = []
    lazy var averagePrice: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureTableView()
        shoppingCart = singleton.getItems(type: .cart)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return }
        itemDetailViewController.item = shoppingCart[indexPath.row]
        itemDetailViewController.row = indexPath.row
//        showDetailViewController(itemDetailViewController, sender: self)
        show(itemDetailViewController, sender: self)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 20, width: view.frame.width, height: 17)
        label.font = UIFont(name: "Arial", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "В корзине \(shoppingCart.count) товар(ов)"
        
        let headerView = UIView()

        headerView.backgroundColor = .systemGray5
       
        headerView.addSubview(label)
        
        return headerView
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
    
    func setupNavigationBar() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = "Корзина"
                
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let favorite = shoppingCart[row]
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

    @IBAction func eraseCartButtonDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "Внимание!", message: "Вы точно хотите очистить корзину?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let acceptAction = UIAlertAction(title: "Подтвердить", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            for item in strongSelf.shoppingCart {
                strongSelf.singleton.changeItemFlag(type: .cart, for: item)
            }
            strongSelf.shoppingCart.removeAll()
            strongSelf.singleton.removeAllFromCart()
            strongSelf.averagePrice = 0
            strongSelf.updateAveragePrice()
            strongSelf.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        
        self.present(alert, animated: true, completion: nil)
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
