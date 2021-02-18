//
//  CategoryCollectionViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 15.02.2021.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {

    var categories: [String] = ["Вспененный полиэтилен", "Теплоизоляция для труб", "Демпферная лента", "Фольга для бани", "Скотч и лента", "Пленка первый сорт", "Плёнка строительаная", "Пленка черная и цветная", "Ветро-влаго-пароизоляция", "Геомембрана", "Пленка термоусадочная", "Пленка мульчирующая", "Пленка для картриджей", "Пленка воздушно-пузырьковая", "Пленка светостабилизированная", "Пленка армированная", "Стрейч пленка для ручного опалечивания", "Стрейч пленка для машинного опалечивания"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        cell.nameLabel.text = categories[indexPath.row]
        // Configure the cell
    
        return cell
    }

    
    //MARK: - Helpers
    func setupNavigationBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.largeTitleDisplayMode = .always
        
    }

}
