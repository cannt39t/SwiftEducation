//
//  ViewController.swift
//  Adapter
//
//  Created by Илья Казначеев on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var authService: AuthentificationService = GoogleAuthentificatorAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createUser(email: "iliakaznacheev@gmail.com", password: "12345678")
    }
    
    func createUser(email: String, password: String) {
        authService.login(email: email, password: password) { user, token in
            print("Auth succeeded: \(user.email), \(token.value)")
        } failure: { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }

    }

}

