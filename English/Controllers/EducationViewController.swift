//
//  EducationViewController.swift
//  English
//
//  Created by Преподаватель on 10.11.2021.
//

import UIKit

class EducationViewController: UIViewController {

    private let userDefualts = UserDefaults()
    private var typeStudes = ["Изучить", "Закрепить", "Повторить"]
    var wordsType: WordTypeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if wordsType != nil {
            userDefualts.set(wordsType!.id, forKey: "wordTypeId")
            userDefualts.set(wordsType!.name, forKey: "wordTypeName")
        }else{
            wordsType = WordTypeModel(id: userDefualts.integer(forKey: "wordTypeId"), name: userDefualts.string(forKey: "wordTypeName") ?? "")
        }
    }

}


extension EducationViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeStudes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCollectionViewCell", for: indexPath) as! EducationCollectionViewCell
        cell.titleLabel.text = typeStudes[indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = Words()
        var wordsCount = userDefualts.integer(forKey: "userWordCount")
        let vc = storyboard?.instantiateViewController(withIdentifier: "saveWord") as! ShowWordViewController
        
        if wordsCount == 0{
            wordsCount = 10
        }
        
        if indexPath.item == 0{
            word.getUserWord(idWordType: wordsType!.id, idWordState: 1, count: wordsCount) { content in
                DispatchQueue.main.async {
                    if content != nil{
                        if content!.count > 0{
                            self.userDefualts.set(1, forKey: "wordState")
                            vc.educationWords = content!
                            vc.wordCount = content!.count
                            
                            self.show(vc, sender: nil)
                        }else{
                            self.sendError(title: "Внимание", message: "Нет слов что бы изучить, повторайте старые слова!")
                        }
                    }else{
                        self.sendError(title: "Внимание", message: "Нет слов что бы изучить, повторайте старые слова")
                    }
                }
            }
        }
        if indexPath.item == 1{
            word.getUserWord(idWordType: wordsType!.id, idWordState: 2, count: wordsCount) { content in
                DispatchQueue.main.async {
                    if content != nil{
                        if content!.count > 0{
                            self.userDefualts.set(2, forKey: "wordState")
                            vc.educationWords = content!
                            vc.wordCount = content!.count
                            
                            self.show(vc, sender: nil)
                        }else{
                            self.sendError(title: "Внимание", message: "Нет слов что бы закрепить, сначала изучите новые слова!")
                        }
                    }else{
                        self.sendError(title: "Внимание", message: "Нет слов что бы закрепить, сначала изучите новые слова!")
                    }
                }
            }
        }
        if indexPath.item == 2{
            word.getUserWord(idWordType: wordsType!.id, idWordState: 3, count: wordsCount) { content in
                DispatchQueue.main.async {
                    if content != nil{
                        if content!.count > 0{
                            self.userDefualts.set(3, forKey: "wordState")
                            vc.educationWords = content!.reversed()
                            vc.wordCount = content!.count
                            
                            self.show(vc, sender: nil)
                        }else{
                            self.sendError(title: "Внимание", message: "Нет слов что бы повторить, сначала изучите новые слова!")
                        }
                    }else{
                        self.sendError(title: "Внимание", message: "Нет слов что бы повторить, сначала изучите новые слова!")
                    }
                }
            }
        }
    }
    
}
