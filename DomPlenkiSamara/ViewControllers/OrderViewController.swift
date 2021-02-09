//
//  OrderViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 01.02.2021.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var totalPrice: String?
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.totalPriceLabel.text = totalPrice

        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - TableVIew Delegate&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 3
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as? OrderTableViewCell
            else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.cellNameLabel.text = "Укажите адрес доставки"
            cell.cellTextField.placeholder = "Адрес"
            return cell
        } else if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                cell.cellNameLabel.text = "Электронная почта"
                cell.cellTextField.text = Singleton.shared.user?.email
            case 1:
                cell.cellNameLabel.text = "Контактные данные"
                cell.cellTextField.text = Singleton.shared.user?.phone
            default:
                cell.cellNameLabel.text = "Комментарии к заказу"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Информация о доставке"
        default:
            return "Информация о получателе"
        }
    }

}
