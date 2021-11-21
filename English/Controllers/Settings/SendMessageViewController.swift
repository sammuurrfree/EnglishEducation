//
//  SendMessageViewController.swift
//  English
//
//  Created by Преподаватель on 19.11.2021.
//

import UIKit

class SendMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    

}
