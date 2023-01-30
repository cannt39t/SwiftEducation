//
//  ViewController.swift
//  DecoratorApp
//
//  Created by Илья Казначеев on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = String(mercedess.getPrice()) + "$"
        }
    }
        
    @IBOutlet weak var commentLabel: UILabel! {
        didSet {
            commentLabel.text = mercedess.getTitle()
        }
    }
    var mercedess: MercedessProtocol = MercedessCLA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func valuChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mercedess = MercedessCLA()
            priceLabel.text = String(mercedess.getPrice()) + "$"
            commentLabel.text = mercedess.getTitle()
        case 1:
            mercedess = MercedessCLA()
            mercedess = AlloyWheels(decorator: mercedess)
            priceLabel.text = String(mercedess.getPrice()) + "$"
            commentLabel.text = mercedess.getTitle()
        case 2:
            mercedess = MercedessCLA()
            mercedess = PanframeRoof(decorator: mercedess)
            priceLabel.text = String(mercedess.getPrice()) + "$"
            commentLabel.text = mercedess.getTitle()
        default:
            break
        }
    }
    
}

