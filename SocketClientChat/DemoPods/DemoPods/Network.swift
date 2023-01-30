//
//  Network.swift
//  DemoPods
//
//  Created by Илья Казначеев on 30.01.2023.
//

import Foundation
import CocoaAsyncSocket

class PingPongServer: NSObject, GCDAsyncSocketDelegate {
    var serverSocket: GCDAsyncSocket!
    var clientSocket: GCDAsyncSocket?
    let queue = DispatchQueue(label: "serverQueue")
    
    override init() {
        super.init()
        serverSocket = GCDAsyncSocket(delegate: self, delegateQueue: queue)
    }

    func startServer() {
        do {
            try serverSocket.accept(onPort: 8080)
            print("Server started on port 8080")
        } catch {
            print("Error starting server: \(error)")
        }
    }

    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        clientSocket = newSocket
        clientSocket?.readData(withTimeout: -1, tag: 0)
    }

    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if let message = String(data: data, encoding: .utf8) {
            print("Received message: \(message)")
            if message == "ping" {
                sock.write("pong".data(using: .utf8)!, withTimeout: -1, tag: 0)
                print("Sent message: pong")
            }
        } else {
            print("Error decoding message")
        }
        sock.readData(withTimeout: -1, tag: 0)
    }

    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        if let error = err {
            print("Socket disconnected with error: \(error.localizedDescription)")
        } else {
            print("Socket disconnected")
        }
    }
}



class PingPongClient: NSObject, GCDAsyncSocketDelegate {
    var socket: GCDAsyncSocket!

    func connectToServer() {
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try socket.connect(toHost: "127.0.0.1", onPort: 8080)
            print("Connected to server")
        } catch {
            print("Error connecting to server: \(error)")
        }
    }

    func sendPing() {
        let pingMessage = "ping"
        let pingData = pingMessage.data(using: .utf8)
        socket.write(pingData, withTimeout: -1, tag: 0)
    }

    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        if let message = String(data: data, encoding: .utf8) {
            print("Received message: \(message)")
            if message == "pong" {
                sock.write("ping".data(using: .utf8)!, withTimeout: -1, tag: 0)
                print("Sent message: ping")
            }
        }
    }
}
