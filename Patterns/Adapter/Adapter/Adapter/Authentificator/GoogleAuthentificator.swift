//
//  GoogleAuthentificator.swift
//  Adapter
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

public struct GoogleUser {
    public var email: String
    public var password: String
    public var token: String
}

public class GoogleAuthentificator {
    
    public func login (
        email: String,
        password: String,
        completion: @escaping (GoogleUser?, Error?) -> Void) {
            let token = "token"
            let user = GoogleUser(email: email, password: password, token: token)
            completion(user, nil)
        }
}
