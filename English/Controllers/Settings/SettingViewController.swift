//
//  SettingViewController.swift
//  English
//
//  Created by Преподаватель on 18.11.2021.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = UserDefaults().integer(forKey: "userWordCount")
        if count < 3 {count = 3}
        textField.text = String(count)
    }

    @IBAction func exitButton(_ sender: Any) {
        UserDefaults().set(0, forKey: "userId")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(vc!, animated: true)
    }
    
    @IBAction func changeData(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "change") as! ChangeDataViewController
        
        switch sender.tag{
            case 1:
                vc.changeType = .password
            case 2:
                vc.changeType = .email
            case 3:
                vc.changeType = .name
            default:
                break
        }
        
        present(vc, animated: true)
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        sendError(message: "Этот функционал будет добавлен позже")
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        if textField.hasText{
            if Int(textField.text!) ?? 0 < 3{
                textField.text = "3"
            }else if Int(textField.text!) ?? 0 > 50{
                textField.text = "50"
            }
            
            UserDefaults().set(Int(textField.text!), forKey: "userWordCount")
        }
    }
    

}
