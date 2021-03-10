//
//  Catalogue+TableViewDelegate.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 19.02.2021.
//

import UIKit

extension CatalogueViewController {
    //MARK: - Delegate&DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalogueItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = catalogueItems[indexPath.row]
        let flag = item.priceTypeFlag
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "catalogueCell") as? CatalogueTableViewCell,
            let price = item.price1,
            let secondPrice = item.price2,
            let thirdPrice = item.price3,
            let fourthPrice = item.price4
        else { return UITableViewCell() }
        cell.cellName.text = item.name
        cell.cellImage.image = item.image

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
        
        cell.favoriteButton.tag = indexPath.row
        
        if item.isFavorite {
            cell.favoriteButton.setImage(UIImage(named: "star.fill")!, for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star")!, for: .normal)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return }
        itemDetailViewController.item = catalogueItems[indexPath.row]
        itemDetailViewController.row = indexPath.row
//        showDetailViewController(itemDetailViewController, sender: self)
        show(itemDetailViewController, sender: self)
    }
}
