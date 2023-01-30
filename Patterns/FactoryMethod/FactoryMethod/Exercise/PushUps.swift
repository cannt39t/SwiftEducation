//
//  PushUps.swift
//  FactoryMethod
//
//  Created by Илья Казначеев on 13.01.2023.
//

import Foundation

class PushUps: Exercise {
    var name: String = "Отжмания"
    
    var type: String = "Руки/Грудь"
    
    func start() {
        print("Начинаем Отжмания")
    }
    
    func stop() {
        print("Заканчиваем Отжмания")
    }
    
}
