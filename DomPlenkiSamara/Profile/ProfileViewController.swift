//
//  ProfileViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 29.01.2021.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    //MARK: - TableVIew Delegate&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as? ProfileTableViewCell,
            let profileHelpCell = tableView.dequeueReusableCell(withIdentifier: "profileHelpCell") as? ProfileTableViewCell
            else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                infoCell.cellLabel.text = "Личные данные"
            case 1:
                infoCell.cellLabel.text = "Адреса доставки"
            default:
                infoCell.cellLabel.text = "Получатели"
            }
            return infoCell
        } else if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                profileHelpCell.cellLabel.text = "Доставка и оплата"
            case 1:
                profileHelpCell.cellLabel.text = "Политика конфиденциальности"
            default:
                profileHelpCell.cellLabel.text = "Обратная связь"
            }
            return profileHelpCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 20, width: view.frame.width, height: 17)
        label.font = UIFont(name: "Arial", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        switch section {
        case 0:
            label.text = "Мои данные"
        default:
            label.text = "Помощь"
        }
        
        let headerView = UIView()

        headerView.backgroundColor = .systemGray5
       
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Мои данные"
        default:
            return "Помощь"
        }
    }
    
    //MARK: - Helpers
    func setupNavigationBar() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = "Профиль"
                
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
}
