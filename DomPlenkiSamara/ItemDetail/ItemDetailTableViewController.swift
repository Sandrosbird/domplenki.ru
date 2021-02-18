//
//  ItemDetailTableViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 16.02.2021.
//

import UIKit

class ItemDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    
    
    //MARK: - Properties
    var item: ShopItem = ShopItem()
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item.isRecent = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1.0
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 20, width: view.frame.width, height: 17)
        label.font = UIFont(name: "Arial", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        switch section {
        case 1:
            label.text = "Описание"
        case 2:
            label.text = "Характеристики"
        default:
           
            return nil
        }
        
        let headerView = UIView()

        headerView.backgroundColor = .systemGray5
       
        headerView.addSubview(label)
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = UITableViewCell()
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailHeaderTableViewCell") as? ItemDetailHeaderTableViewCell else { return emptyCell }
            cell.item = item
            cell.itemImage.image = item.image
            cell.itemNameLabel.text = item.name
            cell.itemPriceLabel.text = item.price
            cell.itemQuantityLabel.text = "₽/ед."
            if item.isFavorite {
                cell.favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
            } else {
                cell.favoriteButton.setImage(UIImage(named: "star"), for: .normal)
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell") as? ItemDetailTableViewCell else { return emptyCell }
            cell.cellLabel.text = item.description
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell") as? ItemDetailTableViewCell else { return emptyCell }
            cell.cellLabel.text = item.properties
            return cell
        }
        return emptyCell
    }

    //MARK: - Helpers
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    

}
