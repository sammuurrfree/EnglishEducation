//
//  MainViewController.swift
//  English
//
//  Created by Преподаватель on 09.11.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let typeStudes = ["Слова", "Аудирование", "Грамматика"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeStudes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCollectionViewCell", for: indexPath) as! EducationCollectionViewCell
        cell.titleLabel.text = typeStudes[indexPath.item]
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item{
            case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "category")
            self.present(vc!, animated: true)
            
            case 1: break
            case 2: break
            default: break
        }
    }
    
}
