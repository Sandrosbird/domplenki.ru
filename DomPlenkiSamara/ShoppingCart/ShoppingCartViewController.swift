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
        if shoppingCart.isEmpty {
            self.tableView.setEmptyMessage("Нет товаров в корзине")
        } else {
            self.tableView.restore()
        }
        
        return shoppingCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = shoppingCart[indexPath.row]
        let flag = item.priceTypeFlag
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopCartCell") as? CatalogueTableViewCell,
            let price = item.price1,
            let secondPrice = item.price2,
            let thirdPrice = item.price3,
            let fourthPrice = item.price4
        else { return UITableViewCell() }
        
        
        cell.cellImage.image = item.image
        cell.cellName.text = item.name
        cell.countLabel.text = "x \(item.count)"
        
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
        
        if item.isFavorite {
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

        headerView.backgroundColor = .systemGray6
       
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
            let price = Int(item.price1!)
            if item.isSale {
                averagePrice! = averagePrice! + (price! * item.count)
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
                item.count = 0
            }
            strongSelf.shoppingCart.removeAll()
            strongSelf.singleton.removeAllFromCart()
            strongSelf.averagePrice = 0
            strongSelf.updateAveragePrice()
            strongSelf.priceLabel.text = "0 ₽"
            strongSelf.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func priceTypeButtonDidTap(_ sender: UIButton) {
        let row = sender.tag
        let indexPath = IndexPath(item: row, section: 0)
        let item = shoppingCart[row]
        
        singleton.changeItemFlag(type: .priceType, for: item)

        tableView.reloadRows(at: [indexPath], with: .none)
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
