//
//  Settings.swift
//  SingletonePattern
//
//  Created by Илья Казначеев on 13.01.2023.
//

import UIKit

class Settings {
    
    static let shared = Settings()
    
    var colorStyle = UIColor.white
    var volumeLevel: Float = 1.0
    
    private init() {}
    
}
