//
//  SelectTrueWordViewController.swift
//  English
//
//  Created by Преподаватель on 10.11.2021.
//

import UIKit

class SelectTrueWordViewController: UIViewController {

    
    @IBOutlet private weak var wordLabel: UILabel!
    
    @IBOutlet private weak var btn1: UIButton!
    @IBOutlet private weak var btn2: UIButton!
    @IBOutlet private weak var btn3: UIButton!
    @IBOutlet private weak var btn4: UIButton!
    
    
    var educationWords: [WordModel] = []
    var wordCount = 0
    private var trueVariant = 100 // Правильный ответ
    private var variant = 1000 // Выбранный ответ
    private let word = Words()
    private var isLast = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateLabels(false)
    }

    
    private func generateLabels(_ isEnglish: Bool) {
        word.getRandomWords(randomWordCunt: 2) { content in
            if content != nil{
                DispatchQueue.main.async { [self] in
                    var array = content!
                    array.append(educationWords.first!)
                    array.shuffle()
                    
                    for (i, arrayWord) in array.enumerated() {
                        if educationWords[0] == arrayWord{
                            trueVariant = i + 1
                        }
                    }
                    
                    if isEnglish {
                        btn1.setTitle(array[0].word1, for: .normal)
                        btn2.setTitle(array[1].word1, for: .normal)
                        btn3.setTitle(array[2].word1, for: .normal)
                        btn4.setTitle(array[3].word1, for: .normal)
                        
                        wordLabel.text = educationWords.first!.translation
                    }else{
                        btn1.setTitle(array[0].translation, for: .normal)
                        btn2.setTitle(array[1].translation, for: .normal)
                        btn3.setTitle(array[2].translation, for: .normal)
                        btn4.setTitle(array[3].translation, for: .normal)
                        
                        wordLabel.text = educationWords.first!.word1
                    }
                    
                }
            }
        }
    }
    
    private func clearButton(){
        btn1.backgroundColor = #colorLiteral(red: 0.1861758828, green: 0.4858052135, blue: 0.3418765664, alpha: 1)
        btn2.backgroundColor = #colorLiteral(red: 0.1861758828, green: 0.4858052135, blue: 0.3418765664, alpha: 1)
        btn3.backgroundColor = #colorLiteral(red: 0.1861758828, green: 0.4858052135, blue: 0.3418765664, alpha: 1)
        btn4.backgroundColor = #colorLiteral(red: 0.1861758828, green: 0.4858052135, blue: 0.3418765664, alpha: 1)
    }
    
    private func selectButton(tag: Int){
        clearButton()
        
        switch tag{
            case 1:
                btn1.backgroundColor = #colorLiteral(red: 0.5040256977, green: 0.771404326, blue: 0.4615821242, alpha: 1)
                variant = 1
            case 2:
                btn2.backgroundColor = #colorLiteral(red: 0.5040256977, green: 0.771404326, blue: 0.4615821242, alpha: 1)
                variant = 2
            case 3:
                btn3.backgroundColor = #colorLiteral(red: 0.5040256977, green: 0.771404326, blue: 0.4615821242, alpha: 1)
                variant = 3
            case 4:
                btn4.backgroundColor = #colorLiteral(red: 0.5040256977, green: 0.771404326, blue: 0.4615821242, alpha: 1)
                variant = 4
            default:
                break
        }
        
    }
    
    func chekVarints() {
        if variant == trueVariant{
            clearButton()
            generateLabels(true)
            isLast = !isLast
        }else{
            sendError(message: "Неправильно. Выберете другой ответ")
        }
    }
    
    
    @IBAction private func allButtonMethod(_ sender: UIButton) {
        selectButton(tag: sender.tag)
    }
    
    
    @IBAction private func nextButton(_ sender: UIButton) {
        
        if isLast{
            if UserDefaults().integer(forKey: "wordState") != 3{
                let bool = word.setWord(idWord: educationWords.first!.id, idState: UserDefaults().integer(forKey: "wordState") + 1)
                print(bool)
            }else{
                let bool = word.setWord(idWord: educationWords.first!.id, idState: UserDefaults().integer(forKey: "wordState"))
                print(bool)
            }
            educationWords.removeFirst()
            
            
            if educationWords.count < 1{
                var count = UserDefaults().integer(forKey: "userWordCount")
                if count == 0 { count = 10 }
                
                let alert = UIAlertController(title: "Замечательно", message: "Вы выучили \(count) новых слов", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { action in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "education") as! EducationViewController
                    self.present(vc, animated: true)
                }))
                
                
                return present(alert, animated: true)
            }
            
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "saveWord") as! ShowWordViewController
            vc.educationWords = educationWords
            vc.wordCount = wordCount
            
            self.show(vc, sender: nil)
        }else{
            chekVarints()
        }
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
