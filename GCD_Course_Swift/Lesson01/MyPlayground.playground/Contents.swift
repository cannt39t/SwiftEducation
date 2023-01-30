import UIKit

// Threads
// Operation
// GCD


// Unix = POSIX System

var thread = pthread_t(bitPattern: 0) // Создаем поток
var attribute = pthread_attr_t()

pthread_attr_init(&attribute)
pthread_create(&thread, &attribute, { UnsafeMutableRawPointer in
    print("unix")
    return nil
}, nil)

// Thread Objective C

var nsthread = Thread {
    print("thread")
}
nsthread.start()
