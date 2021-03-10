//
//  SignInViewController.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 11.02.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var scrollBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollViewNotification()
        configureButtonsFields()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureButtonsFields() {
        StyleButtonsFields.styleFilledButton(signInButton)
        StyleButtonsFields.styleTextField(emailTextField)
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
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        if email == "" && password == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Введите данные", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
                guard let strongSelf = self else { return }
                if let error = error {
                    let alert = UIAlertController(title: "Ошибка!", message: "Логин/пароль введены неверно\n \(error.localizedDescription)", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    strongSelf.present(alert, animated: true, completion: nil)
                } else {
                    FirebaseService.shared.isAuthorized = true
                    strongSelf.performSegue(withIdentifier: "registredLoginSegue", sender: nil)
                }
            }
        }
    }
}
