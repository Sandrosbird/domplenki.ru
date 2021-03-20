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
        searchBar.searchTextField.placeholder = "Поиск по каталогу"
        searchBar.searchTextField.adjustsFontForContentSizeCategory = false
        searchBar.searchTextField.font = UIFont(name: "ArialMT", size: 15)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
//            textField.textColor = .dpBlue
            textField.backgroundColor = .white
            textField.adjustsFontForContentSizeCategory = false
            textField.typingAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialMT", size: 15)]
            textField.defaultTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialMT", size: 15)]
        }
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).adjustsFontForContentSizeCategory = false
        navigationItem.title = "Правильный выбор"
        
        //Следующие строчки делают нав бар маленьким
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintAdjustmentMode = .dimmed
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.expansion : 0, NSAttributedString.Key.font: UIFont(name: "Arial-BoldMT", size: 30)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor = .dpBlue
        
    }
    
    func reloadRecents() {
        let height = recentItemsCollectionView.collectionViewLayout.collectionViewContentSize.height + 50

        recentItemsCollectionViewHeight.constant = height
        recentItemsCollectionView.reloadData()
    }
    
    func preventLargeTitleCollapsing() {
        let dummyView = UIView()
        view.addSubview(dummyView)
        view.sendSubviewToBack(dummyView)
    }
}
