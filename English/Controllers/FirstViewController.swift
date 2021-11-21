//
//  FirstViewController.swift
//  English
//
//  Created by Преподаватель on 17.11.2021.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults().integer(forKey: "userId") != 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
            self.present(vc!, animated: true)
        }
    }

}
