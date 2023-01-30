import UIKit

var greeting = "синхронизацияя и mutex"

//class SafeThread {
//
//    private var mutex = pthread_mutex_t()
//
//    init() {
//        pthread_mutex_init(&mutex, nil)
//    }
//
//    func someMethod(competion: () -> () ) {
//        pthread_mutex_lock(&mutex)
//        competion()
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//
//}

class SafeThread {
    
    private let lockMutex = NSLock()
    
    func someMethod(competion: () -> () ) {
        lockMutex.lock()
        competion()
        defer {
            lockMutex.unlock()
        }
    }
    
}

var arrau = [String]()
let saveThread = SafeThread()

saveThread.someMethod {
    print("test")
    arrau.append("1 thread")
}

saveThread.someMethod {
    arrau.append("3 thread")
}

arrau.append("2 thread")
