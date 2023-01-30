//
//  FactoryExercises.swift
//  FactoryMethod
//
//  Created by Илья Казначеев on 13.01.2023.
//

import Foundation

enum Exercises {
    case jumping, squarts, pushups
}

class FactoryExercises {
    static let defaultFactory = FactoryExercises()
    
    func createExercise(name: Exercises) -> Exercise {
        switch name {
        case .jumping:
            return Jumping()
        case .squarts:
            return Squarts()
        case .pushups:
            return PushUps()
        }
    }
}
