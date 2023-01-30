//
//  ViewController.swift
//  Lesson09
//
//  Created by Илья Казначеев on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        afterBlock(seconds: 5, queue: .main) {
            print("hello")
            self.showAlert()
            print(Thread.current)
        }
    }
    
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(),  complition: @escaping () -> () ) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "hello ilya", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }


}

