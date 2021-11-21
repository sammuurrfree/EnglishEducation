//
//  ProfilViewController.swift
//  English
//
//  Created by Преподаватель on 18.11.2021.
//

import UIKit

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var toDayLAbel: UILabel!
    @IBOutlet weak var toDayProgress: UIProgressView!
    
    @IBOutlet weak var allLabel: UILabel!
    @IBOutlet weak var allProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDef = UserDefaults()
        
        nameLabel.text = "Имя:  \(userDef.string(forKey: "userName")!)"
        emailLabel.text = "Email:   \(userDef.string(forKey: "userEmail")!)"
        
        let count = Words().studyWordAll()
        let toDayCount = Words().studyWordDay()
        
        var allToDayCount = UserDefaults().integer(forKey: "userWordCount")
        if allToDayCount <= 0{
            allToDayCount = 10
        }
        
        
        toDayProgress.progress = Float(toDayCount) / Float(allToDayCount)
        allProgress.progress = Float(count[0] / count[1])
        
        toDayLAbel.text = "\(toDayCount) / \(allToDayCount)"
        allLabel.text = "\(count[0]) / \(count[1])"
    }

    
}
