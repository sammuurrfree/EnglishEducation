//
//  DomainCheker.swift
//  Cinema_12
//
//  Created by Преподаватель on 20.10.2021.
//

import Foundation


// Класс для проверки домена
class EmailCheker{
    
    let email: String
    
    // иницилизатор класса
    init(email: String) {
        self.email = email
    }
    
    // Проверка емаила на правильный патерн
    func chekEmailPatern() -> Bool{
        var sobaka = 0
        var point = 0
        
        for item in email{
            if item == "@"{
                sobaka += 1
            }
            if item == "."{
                point += 1
            }
        }
        
        if sobaka == 1, point == 1{
            return true
        }
        
        return false
    }
    
    
    // Проверка домена верхного увроня
    func chekDomen() -> Bool{
        let emailArray = email.split(separator: ".")
        
        if emailArray.last?.count ?? 0 <= 3{
            return true
        }
        
        return false
    }
    
    // Проверка домена второго увроня
    func chekDomainRegister() -> Bool{
        let emailDomainDownLevel = String(email.split(separator: "@").last?.split(separator: ".").first ?? "")

        let lowlCaseStr = "qwertyuiopasdfghjklzxcvbnm1234567890"
        var isCase = true
        
        for item in emailDomainDownLevel{
            if !lowlCaseStr.contains(item){
                isCase = false
            }
        }
        
        return isCase
    }
    
    
}
