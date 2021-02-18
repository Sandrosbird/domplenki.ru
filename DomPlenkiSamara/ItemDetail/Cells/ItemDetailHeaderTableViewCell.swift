//
//  ItemDetailHeaderTableViewCell.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 16.02.2021.
//

import UIKit
import GMStepper

class ItemDetailHeaderTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var stepper: GMStepper!
    
    lazy var item = ShopItem()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureButtons()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureButtons() {
        if item.isInCart {
            addToCartButton.isHidden = true
            stepper.isHidden = false
            stepper.value = Double((item.count) ?? 0)
        } else {
            addToCartButton.isHidden = false
            stepper.isHidden = true
            StyleButtonsFields.styleFilledButton(addToCartButton)
            addToCartButton.setTitle("Добавить в корзину", for: .normal)
            addToCartButton.setTitleColor(.white, for: .normal)
        }
        
        if item.isFavorite {
            favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }
        StyleButtonsFields.styleFilledButton(addToCartButton)
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonDidTap(_ sender: Any) {
        let favorite = item.isFavorite
        
        if favorite {
            Singleton.shared.changeItemFlag(type: .favorite, for: item)
        } else {
            Singleton.shared.changeItemFlag(type: .favorite, for: item)
        }
        configureButtons()
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: Any) {
        let check = Singleton.shared.checkInCart(item: item)
        let flag = check.0
        
        
        if !flag {
            Singleton.shared.changeItemFlag(type: .cart, for: item)
            Singleton.shared.addToCart(item: item)
            configureButtons()
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        let check = Singleton.shared.checkInCart(item: item)
        let position = check.1
        if stepper.value == 0.0 {
            Singleton.shared.changeItemFlag(type: .cart, for: item)
            Singleton.shared.removeFromCart(index: position)
            configureButtons()
        } else {
            item.count = Int(stepper.value)
        }
    }
    
}
