//
//  ItemDetailViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 26.01.2021.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
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
    
    //MARK: - Helpers
    func configureItems() {
        itemNameLabel.text = item.name
        itemImage.image = item.image
        itemPriceLabel.text = "Цена: \(item.price!) ₽/ед."
        itemDescriptionLabel.text = item.description
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
        if item.isInCart {
            item.isInCart = false
            Singleton.shared.catalogueItems[row].isInCart = false
            Singleton.shared.removeItem(type: .cart, position: row)
            configureButtons()
        } else {
            item.isInCart = true
            Singleton.shared.catalogueItems[row].isInCart = true
            item.count = Int(quantityStepper.value)
            Singleton.shared.recordItem(type: .cart, item: item)
            configureButtons()
        }
    }
    
    @IBAction func favoriteButtonDidTap(_ sender: UIButton) {
        let indexPath = IndexPath(item: row, section: 0)
        let favorites = Singleton.shared.getItems(type: .favorite)
        
        if !favorites.contains(item) {
            item.isFavorite = true
            Singleton.shared.catalogueItems[row].isFavorite = true
            Singleton.shared.recordItem(type: .favorite, item: item)
            
        } else {
            item.isFavorite = false
            Singleton.shared.catalogueItems[row].isFavorite = false
            Singleton.shared.removeItem(type: .favorite, position: row)
        }
        configureButtons()
    }
    
    @IBAction func quantityStepperPressed(_ sender: UIStepper) {
        itemQuantityTextField.text = Int(sender.value).description + " ед."
    }
    
    @IBAction func segmentedControlDidChangedSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            itemDescriptionLabel.text = item.description!
        } else if sender.selectedSegmentIndex == 1 {
            itemDescriptionLabel.text = item.properties!
        }
    }
    
    
    
}
