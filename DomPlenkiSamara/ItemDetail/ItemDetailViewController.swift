//
//  ItemDetailViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 26.01.2021.
//

import UIKit

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    //MARK: - Properties
    var item: ShopItem = ShopItem()
    var row: Int = 0
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureButtons()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Описание"
        } else {
            return "Характеристики"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailCell") as? ProfileTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.cellLabel.text = item.description
        } else if indexPath.section == 1 {
            cell.cellLabel.text = item.properties
        }
        return cell
    }
    
    //MARK: - Helpers
    func configureItems() {
        itemNameLabel.text = item.name
        itemImage.image = item.image
        itemPriceLabel.text = "\(item.price!) ₽/ед."
        
        item.isRecent = true
        itemQuantityTextField.text = String(item.count) + " ед."
    }
    
    func configureButtons() {
        if item.isInCart {
            StyleButtonsFields.styleHollowButton(addToCartButton)
            addToCartButton.setTitle("В корзине", for: .normal)
            addToCartButton.backgroundColor = .clear
            addToCartButton.setTitleColor(.blue, for: .normal)
        } else {
            StyleButtonsFields.styleFilledButton(addToCartButton)
            addToCartButton.setTitle("Добавить в корзину", for: .normal)
            addToCartButton.setTitleColor(.white, for: .normal)
        }
        
        if item.isFavorite {
            favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }
        StyleButtonsFields.styleTextField(itemQuantityTextField)
    }
    
    
    //MARK: - Actions
    
    @IBAction func addToCartButtonDidTap(_ sender: Any) {
        let check = Singleton.shared.checkInCart(item: item)
        let flag = check.0
        let position = check.1
        if flag {
            Singleton.shared.changeItemFlag(type: .cart, for: item)
            Singleton.shared.removeFromCart(index: position)
            configureButtons()
        } else {
            Singleton.shared.changeItemFlag(type: .cart, for: item)
            Singleton.shared.addToCart(item: item)
            configureButtons()
        }
    }
    
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let indexPath = IndexPath(item: row, section: 0)
        
        if item.isFavorite {
            Singleton.shared.changeItemFlag(type: .favorite, for: item)
        } else {
            Singleton.shared.changeItemFlag(type: .favorite, for: item)
        }
        configureButtons()
    }
    
    @IBAction func quantityStepperPressed(_ sender: UIStepper) {
        itemQuantityTextField.text = Int(sender.value).description + " ед."
        item.count = Int(sender.value)
    }
}
