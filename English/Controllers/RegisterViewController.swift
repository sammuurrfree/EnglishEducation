//
//  RegisterViewController.swift
//  English
//
//  Created by Преподаватель on 16.11.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.setBorder(borderColor: registerButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        emailTextField.setBorder(borderColor: registerButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        passwordTextField.setBorder(borderColor: registerButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        nameTextField.setBorder(borderColor: registerButton.backgroundColor?.cgColor ?? UIColor.darkGray.cgColor)
        
    }
    
    
    @IBAction private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction private func NameNext(_ sender: Any) {
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction private func EmailNext(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction private func registation(_ sender: Any) {
        let cheker = EmailCheker(email: emailTextField.text!)
        
        guard emailTextField.hasText, nameTextField.hasText, passwordTextField.hasText else{
            return sendError(message: "Заполните все поля!")
        }
        guard cheker.chekEmailPatern() else {
            return sendError(message: "Email должен соответствовать паттерну 'name@domenname.ru'!")
        }
        guard cheker.chekDomen() else {
            return sendError(message: "Длина домена верхнего уровня - не более 3х символов!")
        }
        guard cheker.chekDomainRegister() else {
            return sendError(message: "Домен второго уровня могут состоять только из маленьких букв и цифр!")
        }
        
        let loader = generateLoader()
        
        Authorization().register(email: emailTextField.text!, name: nameTextField.text!, password: passwordTextField.text!) { isAuth, content in
            if isAuth{
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                    self.present(vc!, animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    self.sendError(message: "Что-то пошло не так. Попытайтесь повторно позже")
                }
            }
        }
        loader.removeFromSuperview()
        
    }
    
    
    
}
