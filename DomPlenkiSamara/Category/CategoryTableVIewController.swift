//
//  CategoryTableVIewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 29.01.2021.
//

import UIKit

class CategoryTableVIewController: UITableViewController {

    var categories: [String] = ["Вспененный полиэтилен", "Теплоизоляция для труб", "Демпферная лента", "Фольга для бани", "Скотч и лента", "Пленка первый сорт", "Плёнка строительаная", "Пленка черная и цветная", "Ветро-влаго-пароизоляция", "Геомембрана", "Пленка термоусадочная", "Пленка мульчирующая", "Пленка для картриджей", "Пленка воздушно-пузырьковая", "Пленка светостабилизированная", "Пленка армированная", "Стрейч пленка для ручного опалечивания", "Стрейч пленка для машинного опалечивания"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        
        cell.textLabel?.text = categories[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    func setupNavigationBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.largeTitleDisplayMode = .always
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
