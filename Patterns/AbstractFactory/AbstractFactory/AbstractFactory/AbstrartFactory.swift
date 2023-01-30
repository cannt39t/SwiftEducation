//
//  AbstrartFactory.swift
//  AbstractFactory
//
//  Created by Илья Казначеев on 23.01.2023.
//

import Foundation

protocol AbstrartFactory {
    
    func createChair() -> Chair
    func createSofa() -> Sofa
    func createTable() -> Table
}
