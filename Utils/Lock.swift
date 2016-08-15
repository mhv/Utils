//
//  Lock.swift
//  Signal
//
//  Created by Mikhail Vroubel on 20/11/2014.
//
//

import Foundation

public class Lock {
    private var spinlock:OSSpinLock = OS_SPINLOCK_INIT
    
    public func tryLock()->(Bool) {
        return withUnsafeMutablePointer(&spinlock, OSSpinLockTry)
    }
    
    public func lock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockLock)
    }
    
    public func unlock() {
        withUnsafeMutablePointer(&spinlock, OSSpinLockUnlock)
    }
    
    public func locked<T>(_ fun:()->T) -> T {
        var result:T!
        withUnsafeMutablePointer(&spinlock) {(lock:UnsafeMutablePointer<OSSpinLock>)->() in
            OSSpinLockLock(lock)
            result = fun()
            OSSpinLockUnlock(lock)
        }
        return result
    }
}

public func locked<T>(_ lock: AnyObject, fun: ()->T) -> T {
    objc_sync_enter(lock)
    let result: T = fun()
    objc_sync_exit(lock)
    return result
}

