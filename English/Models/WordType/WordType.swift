//
//  WordType.swift
//  English
//
//  Created by Преподаватель on 17.11.2021.
//

import Foundation


class WordType{
    
    func getWordType(clouser: @escaping(_ content: [WordTypeModel]?) -> ()){
        var request = URLRequest(url: URL(string: "\(Env.baseUrl)/wordsTypes")!,timeoutInterval: 10)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return clouser(nil)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    let content = try? JSONDecoder().decode([WordTypeModel].self, from: data)
                    clouser(content)
                }else{
                    clouser(nil)
                }
            }else{
                clouser(nil)
            }
        }.resume()

    }
}
