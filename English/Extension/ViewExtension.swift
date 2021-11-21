//
//  ViewExtension.swift
//  English
//
//  Created by Преподаватель on 16.11.2021.
//

import Foundation
import UIKit


extension UIView{
    
    func setBorder(borderColor: CGColor = CGColor(red: 136, green: 181, blue: 141, alpha: 1), borderWidth: CGFloat = 1){
        
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        
    }
    
    
}
