//
//  MainScreen+Helpers.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 19.02.2021.
//

import UIKit

extension MainScreenViewController {
    
    func setupNavigationBar() {
        
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchBar.isTranslucent = false
        StyleButtonsFields.styleSearchTextField(searchBar.searchTextField)
        searchBar.searchTextField.tintColor = .white
        searchBar.tintColor = .white
        searchBar.placeholder = "Поиск по каталогу"
//        searchController.searchResultsUpdater = self
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .dpBlue
            textField.backgroundColor = .white
        }
        
        DispatchQueue.main.async {
            self.navigationItem.title = "Правильный выбор"
            self.navigationItem.largeTitleDisplayMode = .always
        }
        

        //Следующие две строчки делают нав бар маленьким
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        navigationController?.navigationBar.barTintColor = .dpBlue
        
        
//        guard let navigationBar = navigationController?.navigationBar else { return }
//        for sview in navigationBar.subviews {
//            for ssview in sview.subviews {
//                guard let label = ssview as? UILabel else { break }
//                if label.text == self.title {
//                    label.numberOfLines = 0
//                    label.lineBreakMode = .byWordWrapping
//                    label.sizeToFit()
//                    UIView.animate(withDuration: 0.3, animations: {
//                        navigationBar.frame.size.height = 57 + label.frame.height
//                    })
//                }
//            }
//        }
        
    }
    
    func reloadRecents() {
        let height = recentItemsCollectionView.collectionViewLayout.collectionViewContentSize.height
        recentItemsCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
        
        recentItemsCollectionView.reloadData()
    }
}
