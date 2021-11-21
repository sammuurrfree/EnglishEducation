//
//  LoginViewController.swift
//  English
//
//  Created by Преподаватель on 16.11.2021.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.setBorder(borderColor: loginButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        emailTextField.setBorder(borderColor: loginButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        passwordTextField.setBorder(borderColor: loginButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults().integer(forKey: "userId") != 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
            self.present(vc!, animated: true)
        }
    }
    
    @IBAction private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction private func emailNext(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction private func authorization(_ sender: Any) {
        auth()
    }
    
    
    private func auth() {
        if emailTextField.hasText, passwordTextField.hasText{
            let loader = generateLoader()
            
            Authorization().login(email: emailTextField.text!, password: passwordTextField.text!) { isAuth, content, error in
                if isAuth{
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                        self.present(vc!, animated: true)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.sendError(message: error)
                    }
                }
            }
            
            loader.removeFromSuperview()
        }else{
            sendError(message: "Заполните все поля!")
        }
    }
    

}
