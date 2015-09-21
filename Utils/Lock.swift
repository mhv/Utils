//
//  Lock.swift
//  Signal
//
//  Created by Mikhail Vroubel on 20/11/2014.
//
//

import Foundation

class Lock {
    private var spinlock:OSSpinLock = OS_SPINLOCK_INIT
    
    func tryLock()->(Bool) {
        return withUnsafeMutablePointer(&spinlock, OSSpinLockTry)
    }
    
    func lock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockLock)
    }
    
    func unlock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockUnlock)
    }
    
    func locked<T>(fun:()->T) -> T {
        var result:T!
        withUnsafeMutablePointer(&spinlock) {(lock:UnsafeMutablePointer<OSSpinLock>)->() in
            OSSpinLockLock(lock)
            result = fun()
            OSSpinLockUnlock(lock)
        }
        return result
    }
}

public func locked<T>(lock: AnyObject, fun: ()->T) -> T {
    objc_sync_enter(lock)
    let result: T = fun()
    objc_sync_exit(lock)
    return result
}

