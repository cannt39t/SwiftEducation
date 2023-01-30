//
//  Exercise.swift
//  FactoryMethod
//
//  Created by Илья Казначеев on 13.01.2023.
//

import Foundation

protocol Exercise {
    
    var name: String {get}
    var type: String {get}
    
    func start()
    func stop()
    
}
