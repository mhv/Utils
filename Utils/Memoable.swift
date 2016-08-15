//
//  Memoable.swift
//  Utils
//
//  Created by Mikhail Vroubel on 8/15/16.
//  Copyright © 2016 Mikhail Vroubel. All rights reserved.
//

import Foundation

public protocol MemoType:class {
    static func memoKey()->String
}

public protocol Memoable:MemoType {
}

public extension Memoable where Self:MemoType {
    public static func memo(_ name:String)->Self? {
        return Memo.memo(name: name, type: self)
    }
    public func setMemo(_ name:String) {
        Memo.setMemo(name: name, x: self)
    }
}

extension NSObject: Memoable {
    public class func memoKey() -> String {return "NSObject"}
}

class Memo {
    static var Memos = [String:NSMutableDictionary]()
    class func memo<T where T:MemoType>(name:String, type:T.Type)->T? {
        return Memos[type.memoKey()]?[name] as? T
    }
    class func setMemo<T where T:MemoType>(name:String, x:T) {
        let key = x.dynamicType.memoKey()
        var memo = Memos[key]
        if (memo == nil) {
            memo = NSMutableDictionary()
            Memos[key] = memo
        }
        memo![name] = x
    }
}
