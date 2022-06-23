//
//  UsersData.swift
//  git_users
//
//  Created by Lukasz on 22/06/2022.
//

import Foundation

struct UserData: Codable {
    let items: [Items]
}

struct Items: Codable {
    let login: String
    let avatar_url: String
}
