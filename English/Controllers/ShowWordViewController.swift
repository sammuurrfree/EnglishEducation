//
//  ShowWordViewController.swift
//  English
//
//  Created by Преподаватель on 11.11.2021.
//

import UIKit

class ShowWordViewController: UIViewController {
    
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private  weak var tanscriptionLabel: UILabel!
    @IBOutlet private weak var translateLabel: UILabel!
    
    var educationWords: [WordModel] = []
    var wordCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = "\(wordCount - educationWords.count + 1) / \(wordCount)"
        wordLabel.text = educationWords.first?.word1 ?? ""
        tanscriptionLabel.text = educationWords.first?.transcription ?? ""
        translateLabel.text = educationWords.first?.translation ?? ""
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "select") as! SelectTrueWordViewController
        
        vc.educationWords = educationWords
        vc.wordCount = wordCount
        
        self.present(vc, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы действительно хотите прекратить обучение, прогресс будет утерян!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { action in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "education") as! EducationViewController
            self.present(vc, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .default))
        
        present(alert, animated: true)
        
    }
    
}
