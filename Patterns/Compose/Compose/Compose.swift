//
//  Compose.swift
//  Compose
//
//  Created by Илья Казначеев on 28.01.2023.
//

import Foundation

protocol Compose {
    
    var name: String {get set}
    func showContent() -> Any
    func addComponent(component: Compose) -> Void
    func contentCount() -> Int
    
}


class File: Compose {

    var name: String
    
    internal init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        self.name
    }
    
    func addComponent(component: Compose) {
        print("You cant add any files to file\nYou should add file into folder")
    }
    
    func contentCount() -> Int {
        1
    }
}

class Folder: Compose {
    
    var name: String
    private var contentArray = [Compose]()
    
    internal init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        contentArray
    }
    
    func addComponent(component: Compose)  {
        contentArray.append(component)
    }
    
    func contentCount() -> Int {
        contentArray.count
    }
}
