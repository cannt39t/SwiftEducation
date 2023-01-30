import UIKit

var greeting = "NSCondition()?"

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()


class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printMethod()
    }
    
    private func printMethod() {
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Printer exit")
    }
    
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writeMethod()
    }
    
    private func writeMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        pthread_cond_signal(&condition)
        available = true
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer exit")
    }
    
}


let conditionWriter = ConditionMutexWriter()
let conditionPrinter = ConditionMutexPrinter()
// conditionPrinter.start()
// conditionWriter.start()


let nsCondition = NSCondition()
var availables = false

var strsFromUser = [String]()

let str = "fasdfasd"

class WriterThread: Thread {
    
    override func main() {
        nsCondition.lock()
        print("Enter the WriterThread")
        print(str)
        strsFromUser.append(str)
        availables = true
        nsCondition.signal()
        nsCondition.unlock()
        print("Exit  the WriterThread")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        nsCondition.lock()
        print("Enter  the PrintThread")
        while (!availables) {
            nsCondition.wait()
        }
        print(strsFromUser)
        availables = false
        nsCondition.unlock()
        print("Exit the PrintThread")
    }
}

let writerrr = WriterThread()
let printerr = PrinterThread()
printerr.start()
writerrr.start()


