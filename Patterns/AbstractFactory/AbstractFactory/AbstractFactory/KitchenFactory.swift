//
//  KitchenFactory.swift
//  AbstractFactory
//
//  Created by Илья Казначеев on 23.01.2023.
//

import Foundation

class KitchenFactory: AbstrartFactory {
    
    func createChair() -> Chair {
        print("Стул для кухни создан")
        return ChairKitchen ()
    }
    
    func createSofa() -> Sofa {
        print("Диван для кухни создан")
        return SofaKitchen()
    }
    
    func createTable() -> Table {
        print("Стол для кухни создан")
        return TableKitchen()
    }
    
}
