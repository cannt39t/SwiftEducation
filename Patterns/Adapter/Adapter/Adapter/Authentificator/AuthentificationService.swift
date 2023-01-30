//
//  AuthentificationService.swift
//  Adapter
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

public struct User {
    public let email: String
    public let password: String
}

public struct Token {
    public let value: String
}

public protocol AuthentificationService {
    
    func login(email: String,
               password: String,
               sucsess: @escaping(User , Token) -> Void,
               failure: @escaping(Error?) -> Void)
    
}
