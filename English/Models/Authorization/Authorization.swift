//
//  Authorization.swift
//  English
//
//  Created by Преподаватель on 17.11.2021.
//

import Foundation


class Authorization{
    
    private let userDefualts = UserDefaults()
    
    func login(email: String, password: String, closure: @escaping (_ isAuth: Bool, _ content: UserModel?, _ error: String?) -> ()){

        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(Env.baseUrlFromUser)/user/login")!,timeoutInterval: 10)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return closure(false, nil, nil)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    let userData = try? JSONDecoder().decode(UserModel.self, from: data)
                    self.userDefualts.set(userData?.id ?? 0, forKey: "userId")
                    self.userDefualts.set(userData?.name ?? "", forKey: "userName")
                    self.userDefualts.set(userData?.email ?? "", forKey: "userEmail")
                    closure(true, userData, nil)
                }else{
                    closure(false, nil, String(data: data, encoding: .utf8))
                }
            }else{
                closure(false, nil, "Что-то пошло не так. Попытайтесь повторно позже")
            }
            
            
        }.resume()
    }
    
    func register(email: String, name: String, password: String, closure: @escaping (_ isAuth: Bool, _ content: UserModel?) -> ()){

        let parameters = "{\n  \"name\": \"\(name)\",\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(Env.baseUrlFromUser)/user/register")!,timeoutInterval: 10)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return closure(false, nil)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    let userData = try? JSONDecoder().decode(UserModel.self, from: data)
                    self.userDefualts.set(userData?.id ?? 0, forKey: "userId")
                    self.userDefualts.set(userData?.name ?? "", forKey: "userName")
                    self.userDefualts.set(userData?.email ?? "", forKey: "userEmail")
                    closure(true, userData)
                }else{
                    closure(false, nil)
                }
            }else{
                closure(false, nil)
            }
            
            
        }.resume()
    }

}
