import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//print(Thread.current)

//let operation1 = {
//
//    print("Start")
//    print(Thread.current)
//    print("Finish")
//
//}
//
//print(Thread.current)
//
//var result: String?
//let concatOperation = BlockOperation {
//    result = "cantt39t"
//    print(Thread.current)
//}
// let queue = OperationQueue()
//queue.addOperation(concatOperation)
//print(result)

//let queue = OperationQueue()
//queue.addOperation {
//    print(Thread.current)
//    print("qq")
//}

class MyThread: Thread {
    
    override func main() {
        print(Thread.current)
        print("test main thread")
    }
    
}

//let myThread = MyThread()
//
//myThread.start()

class OpeartionA : Operation {
    
    override func main() {
        print(Thread.current)
        print("test main thread")
    }
    
    
}

let operationA = OpeartionA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)

