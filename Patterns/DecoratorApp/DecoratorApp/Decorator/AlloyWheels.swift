//
//  AlloyWheels.swift
//  DecoratorApp
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

class AlloyWheels: MercedessDecorator {
    
    required init(decorator: MercedessProtocol) {
        super.init(decorator: decorator)
    }
    
    override func getTitle() -> String {
        return super.getTitle() + "\npremium wheelsf"
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 1_500
    }
    
}
