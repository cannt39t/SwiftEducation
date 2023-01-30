//
//  MercedessDecorator.swift
//  DecoratorApp
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

class MercedessDecorator: MercedessProtocol {
    
    private let decoratorType: MercedessProtocol
    
    required init(decorator: MercedessProtocol) {
        self.decoratorType = decorator
    }
    
    func getTitle() -> String {
        return decoratorType.getTitle()
    }
    
    func getPrice() -> Double {
        return decoratorType.getPrice()
    }
}
