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
    @IBOutlet weak var performOrderButton: UIButton!
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.totalPriceLabel.text = totalPrice

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        configureButtons()
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
                cell.cellTextField.placeholder = "E-mail"
            case 1:
                cell.cellNameLabel.text = "Данные для связи"
                cell.cellTextField.text = Singleton.shared.user?.phone
                cell.cellTextField.placeholder = "Номер телефона"
            default:
                cell.cellNameLabel.text = "Комментарии к заказу"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 20, width: view.frame.width, height: 17)
        label.font = UIFont(name: "Arial", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        switch section {
        case 0:
            label.text = "Информация о доставке"
        default:
            label.text = "Информация о получателе"
        }
        
        let headerView = UIView()

        headerView.backgroundColor = .systemGray6
       
        headerView.addSubview(label)
        
        return headerView
    }
    
    private func configureButtons() {
        StyleButtonsFields.styleFilledButton(performOrderButton)
    }

}
