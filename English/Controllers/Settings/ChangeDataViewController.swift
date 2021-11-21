//
//  ChangeDataViewController.swift
//  English
//
//  Created by Преподаватель on 19.11.2021.
//

import UIKit

class ChangeDataViewController: UIViewController {

    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var repeatDataTextField: UITextField!
    
    var changeType: ChangeData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLAbel.text = "Изменить \(changeType.rawValue)"
        dataTextField.placeholder = "Новый \(changeType.rawValue)"
        repeatDataTextField.placeholder = "Повторить \(changeType.rawValue)"
    }
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        
        guard dataTextField.hasText, repeatDataTextField.hasText else {
            return sendError(message: "Заполните все поля!")
        }
        guard dataTextField.text == repeatDataTextField.text else {
            return sendError(message: "Оба поля должны быть одинаковы!")
        }
        
        if changeType == .email{
            let cheker = EmailCheker(email: dataTextField.text!)

            guard cheker.chekEmailPatern() else {
                return sendError(message: "Email должен соответствовать паттерну 'name@domenname.ru'!")
            }
            guard cheker.chekDomen() else {
                return sendError(message: "Длина домена верхнего уровня - не более 3х символов!")
            }
            guard cheker.chekDomainRegister() else {
                return sendError(message: "Домен второго уровня могут состоять только из маленьких букв и цифр!")
            }
        }
        User().changeUserData(changeType: changeType, data: dataTextField.text!.replacingOccurrences(of: " ", with: "")) {resultBoll, isRepeatLastData in
            DispatchQueue.main.async {
                if resultBoll{
                    self.sendError(title: "Сохраненно", message: "Сохранение прошло успешно!")
                    
                }else if isRepeatLastData{
                    self.sendError(title: "Данные уже используются", message: "У вас и так такие данные")
                }
                self.sendError(title: "Что-то пошло не так", message: "Повторите попытку позже")
            }
        }
        
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}
