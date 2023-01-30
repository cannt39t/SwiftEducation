import UIKit
import Darwin

var greeting = "Lock"

// Unix
// Защита записи или чтения

class ReadWriteLock {
    
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    // Critical Section
    private var globalProperty: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attribute)
    }
    
    public var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
    
}

// SpinLock


class SpinLock {
    private var lock = OS_SPINLOCK_INIT
    
    func some() {
        OSSpinLockLock(&lock)
        
        // whatever
        
        OSSpinLockUnlock(&lock)
    }
}

//

class UnfairLock {
    
    private var lock = os_unfair_lock_t(nil)
    
    var arrau =  [Int]()
    
    func some() {
        os_unfair_lock_lock(lock!)
        arrau.append(12)
        os_unfair_lock_unlock(lock!)
    }
    
}


// Most popular (from Obj C)

class SynchronizedObjc {
    
    private let lock = NSObject()
    
    var array = [Int]()
    
    func some() {
        objc_sync_enter(lock)
        array.append(232)
        objc_sync_exit(lock)
    }
}
