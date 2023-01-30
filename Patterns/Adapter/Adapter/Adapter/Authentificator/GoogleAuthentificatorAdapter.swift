//
//  GoogleAuthentificatorAdapter.swift
//  Adapter
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

class GoogleAuthentificatorAdapter: AuthentificationService {
    
    private var authethicator = GoogleAuthentificator()
    
    public func login(email: String,
               password: String,
               sucsess: @escaping (User, Token) -> Void,
               failure: @escaping (Error?) -> Void) {
        authethicator.login(email: email, password: password) { current_user, error in
            guard let current_user = current_user else {
                failure(error)
                return
            }
            let user = User(email: current_user.email, password: current_user.password)
            let token = Token(value: current_user.token)
            sucsess(user, token)
        }
    }
}
