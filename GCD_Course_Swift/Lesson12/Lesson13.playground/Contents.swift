import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Barrier"

var array = [Int]()

//for i in 0...9 {
//    array.append(i)
//}
//
//print(array)
//print(array.count)

//DispatchQueue.concurrentPerform(iterations: 10) { iter in
//    array.append(iter)
//}
//
//print(array)
//print(array.count)


class SaveArray<T> {
    
    private var array = [T]()
    private let queue = DispatchQueue(label: "cocurrent", attributes: .concurrent)
    
    public func append (_ value: T) {
        queue.async(flags: .barrier) {
            print(value)
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        
        queue.sync {
            result = self.array
        }
        
        return result
    }
    
}

var arraySafe = SaveArray<Int>()

DispatchQueue.concurrentPerform(iterations: 10) { iter in
    arraySafe.append(iter)
}

print(arraySafe.valueArray)
