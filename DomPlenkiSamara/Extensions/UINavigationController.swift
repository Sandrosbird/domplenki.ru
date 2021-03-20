//
//  UINavigationController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 08.03.2021.
//

import UIKit

extension UINavigationController {
    func forceUpdateNavigationBar() {
        DispatchQueue.main.async {
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.sizeToFit()
        }
    }
}
