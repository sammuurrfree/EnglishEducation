//
//  CategoryViewController.swift
//  English
//
//  Created by Преподаватель on 09.11.2021.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var сategoryStudes: [WordTypeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WordType().getWordType { [self] content in
            if content != nil{
                DispatchQueue.main.async { [self] in
                    сategoryStudes = content!
                    collectionView.reloadData()
                }
            }
        }
    }
}


extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return сategoryStudes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeStudyCollectionViewCell", for: indexPath) as! TypeStudyCollectionViewCell
        cell.titleLabel.text = сategoryStudes[indexPath.item].name
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "education") as! EducationViewController
        vc.wordsType = сategoryStudes[indexPath.item]
        
        self.present(vc, animated: true)
    }
    
}
