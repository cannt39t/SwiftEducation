//
//  MercedessCLA.swift
//  DecoratorApp
//
//  Created by Илья Казначеев on 25.01.2023.
//

import Foundation

class MercedessCLA: MercedessProtocol {
    func getTitle() -> String {
        return "Mercedess CLA"
    }
    
    func getPrice() -> Double {
        return 12_000
    }
}
