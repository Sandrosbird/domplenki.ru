//
//  StartScreenViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.01.2021.
//

import UIKit

class StartScreenViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        configureScrollView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func signInButtonDidTap(_ sender: Any) {
        guard let phone = phoneTextField.text else { return }
        if phone == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Введите данные", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            Singleton.shared.user = User(fullName: "", phone: phoneTextField.text!, email: "", city: nil, street: nil, house: nil, apartment: nil)
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    //MARK: - Helpers
    func configureButtons() {
        StyleButtonsFields.styleFilledButton(signInButton)
        
        StyleButtonsFields.styleTextField(phoneTextField)
    }

    func configureScrollView() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        scrollBottomConstraint.constant = -frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollBottomConstraint.constant = 0
    }

}
