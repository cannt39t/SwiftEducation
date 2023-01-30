//
//  TwoViewController.swift
//  Lesson09
//
//  Created by Илья Казначеев on 29.12.2022.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {iter in
//                print("\(iter) times")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "own", attributes: [.concurrent, .initiallyInactive])
        inactiveQueue.async {
            print("Done")
        }
        print("Not started")
        inactiveQueue.activate()
        print("Actibvated")
        inactiveQueue.suspend()
        print("Queue sleep")
        inactiveQueue.resume()
    }

}
