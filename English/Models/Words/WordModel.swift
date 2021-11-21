//
//  WordModel.swift
//  English
//
//  Created by Преподаватель on 08.11.2021.
//

import Foundation


struct WordModel: Codable, Equatable{
    
    let id: Int
    let idwordType: Int
    let word1: String
    let transcription: String
    let translation: String
}

struct CountData: Codable{
    let date: String
    let count: Int
}

struct CountDataAllTime: Codable{
    let allWordCount: Int
    let count: Int
}

enum StateWord: Int{
    case study = 0
    case consolidate = 1
    case repeating = 2
}
