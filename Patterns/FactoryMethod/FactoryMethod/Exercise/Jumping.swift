//
//  Jumping.swift
//  FactoryMethod
//
//  Created by Илья Казначеев on 13.01.2023.
//

import Foundation

class Jumping: Exercise {
    var name: String = "Прыжки"
    
    var type: String = "Ноги"
    
    func start() {
        print("Начинаем прыжки")
    }
    
    func stop() {
        print("Заканчиваем прыжки")
    }
    
    
}
