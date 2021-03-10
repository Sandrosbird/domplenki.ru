//
//  StartScreenViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 11.02.2021.
//

import UIKit

class StartScreenViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var authoriseButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        FirebaseService.shared.addUserListener(controller: self)
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureButtons() {
        StyleButtonsFields.styleFilledButton(authoriseButton)
        StyleButtonsFields.styleHollowButton(registerButton)
    }
}
