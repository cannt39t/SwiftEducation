import UIKit

// GCD - верхнее уровнивая библиотека

class QueueTest1 {
    
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let coccurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
    
}


class QueueTest2 {
    
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
    
}

