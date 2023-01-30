//
//  ViewController.swift
//  DemoPods
//
//  Created by Илья Казначеев on 30.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let server = PingPongServer()
        server.startServer()

        // Connect the client to the server
        let client = PingPongClient()
        client.connectToServer()

        // Send the first "ping" message from the client
        client.sendPing()
    }


}

