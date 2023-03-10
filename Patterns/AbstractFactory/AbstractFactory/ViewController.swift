//
//  ViewController.swift
//  AbstractFactory
//
//  Created by Илья Казначеев on 23.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var chair: Chair?
    var table: Table?
    var sofa: Sofa?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func kitchenOrder(_ sender: Any) {
        chair = KitchenFactory().createChair()
        table = KitchenFactory().createTable()
        sofa = KitchenFactory().createSofa()
    }
    
    @IBAction func bedroomOrder(_ sender: Any) {
        chair = BedroomFactory().createChair()
        table = BedroomFactory().createTable()
        sofa = BedroomFactory().createSofa()
    }
    
}

