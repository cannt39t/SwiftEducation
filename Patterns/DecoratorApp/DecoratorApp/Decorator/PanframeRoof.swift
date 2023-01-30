//
//  PanframeRoof.swift
//  DecoratorApp
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

class PanframeRoof: MercedessDecorator {
    
    required init(decorator: MercedessProtocol) {
        super.init(decorator: decorator)
    }
    
    override func getTitle() -> String {
        return super.getTitle() + "\npremium roof"
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 2_000
    }
    
}
