//
//  User.swift
//  English
//
//  Created by Преподаватель on 19.11.2021.
//

import Foundation


class User {
    
    private let userDefualts = UserDefaults()
    
    private func getUser(id: Int) -> UserModel? {
        let semaphore = DispatchSemaphore(value: 0)
        var returnData: UserModel? = nil
        
        var request = URLRequest(url: URL(string: "\(Env.baseUrlFromUser)/user/\(id)")!,timeoutInterval: 10)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
                return
            }
            guard error == nil else{
                semaphore.signal()
                return
            }

            returnData = try? JSONDecoder().decode(UserModel.self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return returnData
    }
    
    
    func changeUserData(changeType: ChangeData, data: String, complition: @escaping(_ result: Bool, _ isRepeatLastData: Bool) -> ()) {
        let userInfo = getUser(id: userDefualts.integer(forKey: "userId"))
        guard userInfo != nil else{ return }
        var parameters = ""
        
        
        switch changeType{
        case .password:
            parameters = "{\n  \"name\": \"\(userInfo!.name)\",\n  \"email\": \"\(userInfo!.email)\",\n  \"password\": \"\(data)\"\n}"
        case .email:
            parameters = "{\n  \"name\": \"\(userInfo!.name)\",\n  \"email\": \"\(data)\",\n  \"password\": \"\(userInfo!.password)\"\n}"
        case .name:
            parameters = "{\n  \"name\": \"\(data)\",\n  \"email\": \"\(userInfo!.email)\",\n  \"password\": \"\(userInfo!.password)\"\n}"
        }
        
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "\(Env.baseUrlFromUser)/user/\(userDefualts.integer(forKey: "userId"))")!,timeoutInterval: 10)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    guard let data = data else { return complition(false, false) }
                    let userData = try? JSONDecoder().decode(UserModel.self, from: data)
                    
                    self.userDefualts.set(userData?.name ?? "", forKey: "userName")
                    self.userDefualts.set(userData?.email ?? "", forKey: "userEmail")
                    
                    complition(true, false)
                }else if httpResponse.statusCode == 400{
                    complition(false, true)
                }
            }else{
                complition(false, false)
            }
        }.resume()
    }
    
    
}
