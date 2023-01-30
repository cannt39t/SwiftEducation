import UIKit

var str = "NSRecursiveLock"

class RecursiveMutexTest {
    private var mutex =  pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }
    
    func firstTask() {
        pthread_mutex_lock(&mutex)
        secondTask()
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
    
    private func secondTask() {
        pthread_mutex_lock(&mutex)
        print("finish")
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}

let recursive = RecursiveMutexTest()
recursive.firstTask()




let recursiveLock = NSLock()

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        print("thread is locked")
        task2()
        defer {
            recursiveLock.unlock()
        }
        print("Exit main")
    }
    
    private func task2() {
        recursiveLock.lock()
        print("Enter 2 func")
        defer {
            recursiveLock.unlock()
        }
        print("Exit 2 func")
    }
}

let thread = RecursiveThread()
thread.start()
