//
//  SignInViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 11.02.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var scrollBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollViewNotification()
        configureButtonsFields()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    func configureButtonsFields() {
        StyleButtonsFields.styleFilledButton(signInButton)
        StyleButtonsFields.styleTextField(phoneTextField)
        StyleButtonsFields.styleTextField(passwordTextField)
    }
    
    func configureScrollViewNotification() {
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
        
        scrollBottonConstraint.constant = -frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollBottonConstraint.constant = 0
    }

    @IBAction func signUpButtonDidTap(_ sender: Any) {
        guard
            let phone = phoneTextField.text,
            let password = passwordTextField.text
        else { return }
        if phone == "" && password == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Введите данные", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            
            
            performSegue(withIdentifier: "registredLoginSegue", sender: nil)
        }
    }
}
