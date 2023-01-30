import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "cantt39t", attributes: .concurrent)

//let semaphore = DispatchSemaphore(value: 1)

//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 1")
//    semaphore.signal()
//}
//
//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 2")
//    semaphore.signal()
//}
//
//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 3")
//    semaphore.signal()
//}

//let sem = DispatchSemaphore(value: 4)
//DispatchQueue.concurrentPerform(iterations: 10) { iter in
//    sem.wait(timeout:  DispatchTime.distantFuture)
//
//    sleep(1)
//    print("Block \(iter)")
//
//    sem.signal()
//}

class SemaphoreTest {
    
    private let semaphore = DispatchSemaphore(value: 4)
    
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        semaphore.wait() // -1
        array.append(id)
        print("test array count: \(array.count)")
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal() // +1
    }
    
    public func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(222)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(333)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(444)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(444)
            print(Thread.current)
        }
    }
}

let semaphoretest = SemaphoreTest()
semaphoretest.startAllThread()
