//
//  UsersManager.swift
//  git_users
//
//  Created by Lukasz on 22/06/2022.
//

import Foundation

protocol UserManagerDelegate {
    func didUpdateUsers(users: Users)
}

struct UsersManager {
    
    let usersURL = "https://api.github.com/users"
    let userURL = "https://api.github.com/search/users"
    var delegate : UserManagerDelegate?
    
    func fetchUser(userName: String) {
        let urlString = "\(userURL)?q=\(userName)+in%3Ausername"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let users = self.parseJSON(userData: safeData) {
                        self.delegate?.didUpdateUsers(users: users)
                    }
                }
                
            }
            task.resume()
        }
    }
    func parseJSON(userData: Data) -> Users? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UserData.self, from: userData)
            //print(decodedData.items)
            //let items = decodedData.items
            //for item in items {
             //   let login = item.login
            //    let avatar = item.avatar_url
               // print(login)
               // print(avatar)
            //}
            let login = decodedData.items[0].login
            let avatar = decodedData.items[0].avatar_url
                let user = [UserModel(title: login, image: avatar)]
                let users = Users(user: user)
           //print(users)
            return users
    
        } catch {
            print(error)
            return nil
        }
    }
}

