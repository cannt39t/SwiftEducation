//
//  ViewController.swift
//  SingletonePattern
//
//  Created by Илья Казначеев on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Settings.shared.colorStyle)
    }


}

