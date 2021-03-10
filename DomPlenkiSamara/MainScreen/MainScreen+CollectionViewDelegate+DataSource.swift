//
//  MainScreen+CollectionViewDelegate+DataSource.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 19.02.2021.
//

import UIKit

extension MainScreenViewController {
    //MARK: - Delegate&DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == catalogueActionsCollectionView) {
            return 2
        }
        
        if recents.isEmpty {
            self.recentItemsCollectionView.setEmptyMessage("Нет недавно просмотренных товаров")
        } else {
            self.catalogueActionsCollectionView.restore()
        }
        return recents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalogueActionsCollectionView {
            guard let catalogueActionsCell = catalogueActionsCollectionView.dequeueReusableCell(withReuseIdentifier: "catalogueActionsCell", for: indexPath) as? CatalogueActionCollectionViewCell else { return UICollectionViewCell() }
            
            catalogueActionsCell.cellNameLabel.text = catalogueActions[indexPath.row]
            switch indexPath.row {
            case 0:
                catalogueActionsCell.cellImage.image = UIImage(named: "list.dash")
                catalogueActionsCell.cellImage.highlightedImage = UIImage(named: "list.dash")
                catalogueActionsCell.backgroundColor = UIColor.dpBlue
            default:
                catalogueActionsCell.cellImage.image = UIImage(named: "percent")
                catalogueActionsCell.cellImage.highlightedImage = UIImage(named: "percent")
                
                catalogueActionsCell.backgroundColor = UIColor.systemGray5
                catalogueActionsCell.cellNameLabel.textColor = .dpBlue
                catalogueActionsCell.cellNameLabel.highlightedTextColor = .dpBlue
            }
            
            catalogueActionsCell.layer.cornerRadius = 5
            catalogueActionsCell.layer.masksToBounds = true
            
            return catalogueActionsCell
        } else if collectionView == recentItemsCollectionView {
            guard
                let recentItemsCell = recentItemsCollectionView.dequeueReusableCell(withReuseIdentifier: "recentItemsCell", for: indexPath) as? RecentItemsCollectionViewCell,
                let price = recents[indexPath.row].price1,
                let secondPrice = recents[indexPath.row].price2
            else { return UICollectionViewCell() }
            recentItemsCell.cellNameLabel.text = recents[indexPath.row].name
            recentItemsCell.cellPriceLabel.text = "Розн.: \(price) ₽"
            
            recentItemsCell.cellWholesalePriceLabel.text = "Опт.: \(secondPrice) ₽"
            
            recentItemsCell.cellImage.image = recents[indexPath.row].image
            return recentItemsCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView == catalogueActionsCollectionView {
            if indexPath.row == 0 {
                performSegue(withIdentifier: "toCatalogue", sender: nil)
            } else {
                performSegue(withIdentifier: "toActions", sender: nil)
            }
        } else if collectionView == recentItemsCollectionView {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let itemDetailViewController = storyboard.instantiateViewController(identifier: "ItemDetailTableViewController") as? ItemDetailTableViewController else { return true }
            itemDetailViewController.item = recents[indexPath.row]
            itemDetailViewController.row = indexPath.row
//            showDetailViewController(itemDetailViewController, sender: self)
            show(itemDetailViewController, sender: self)
        }
        return true
    }
}
