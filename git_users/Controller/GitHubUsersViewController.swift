//
//  ViewController.swift
//  git_users
//
//  Created by Lukasz on 07/06/2022.
//

import UIKit

class GitHubUsersViewController: UIViewController, UITextFieldDelegate, UserManagerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
   
    var usersManager = UsersManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersManager.delegate = self
        searchTextField.delegate = self

    }
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type user name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let user = searchTextField.text {
            usersManager.fetchUser(userName: user)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateUsers(users: Users) {
      // print(users)
    }

}

