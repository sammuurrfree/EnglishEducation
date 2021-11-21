//
//  ViewControllerExtension.swift
//  English
//
//  Created by Преподаватель on 17.11.2021.
//

import Foundation
import UIKit


extension UIViewController{
    
    func generateLoader() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView()
        loader.center = view.center
        view.addSubview(loader)
        
        loader.startAnimating()
        
        return loader
    }
    
    
    func sendError(title: String = "Ошибка", message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
    
}
