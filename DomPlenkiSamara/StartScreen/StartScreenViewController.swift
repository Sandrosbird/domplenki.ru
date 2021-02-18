//
//  StartScreenViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 11.02.2021.
//

import UIKit

class StartScreenViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var authorizeButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    private func configureButtons() {
        StyleButtonsFields.styleFilledButton(authorizeButton)
        StyleButtonsFields.styleHollowButton(registerButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
