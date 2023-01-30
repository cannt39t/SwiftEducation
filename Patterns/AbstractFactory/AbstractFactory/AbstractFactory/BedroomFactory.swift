//
//  BedroomFactory.swift
//  AbstractFactory
//
//  Created by Илья Казначеев on 23.01.2023.
//

import Foundation
 
class BedroomFactory: AbstrartFactory {
    func createChair() -> Chair {
        print("Стул для спальни создан")
        return ChairBedroom()
    }
    
    func createSofa() -> Sofa {
        print("Диван для спальни создан")
        return SofaBedroom()
    }
    
    func createTable() -> Table {
        print("Стол для спальни создан")
        return CoffeTable()
    }
    
}
