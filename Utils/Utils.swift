//
//  Pusher+Utils.swift
//  Signal
//
//  Created by Mikhail Vroubel on 13/09/2014.
//
//

import UIKit

public func PostNote(name:String! = nil, object: AnyObject? = nil, userInfo:[NSObject : AnyObject]? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo:userInfo)
}

public class Box<T> {
    public var value : T
    public init(_ value: T) {self.value = value}
}

extension Dictionary {
    public func map<K,V>(@noescape transform: (Dictionary.Generator.Element) -> (K,V)) -> Dictionary<K,V> {
        var dict = Dictionary<K,V>()
        for e in self {
            let (k,v) = transform(e)
            dict[k] = v
        }
        return dict
    }
}