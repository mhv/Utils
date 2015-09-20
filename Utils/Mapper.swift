//
//  File.swift
//  Signal
//
//  Created by Mikhail Vroubel on 07/02/2015.
//
//

import Foundation
// import Memo

@objc public class Mapper : NSObject {
    override public class func memoKey() -> String {return "Mapper"}
    public func to(t:AnyObject?)->AnyObject? {return t}
    public func back(u:AnyObject?)->AnyObject? {return u}
    
    public class func joinPath(name:String) -> Mapper {
        let maps = name.componentsSeparatedByString(".").flatMap {Mapper.memo($0)}
        return join(maps)
    }
    public class func join(maps:[Mapper]) -> Mapper {
        return ClosureMapper(
            to:{Array(Array(Array(maps.reverse()))).reduce($0) { res, next in next.to(res)}},
            back: {maps.reduce($0) { res, next in next.back(res)}}
        );
    }
}

@objc public class ClosureMapper:Mapper {
    let _to:AnyObject?->AnyObject?
    override public func to(t: AnyObject?) -> AnyObject? {return _to(t)}
    let _back:AnyObject?->AnyObject?
    override public func back(u: AnyObject?) -> AnyObject? {return _back(u)}
    
    public init (to:AnyObject?->AnyObject? = {_ in nil}, back:AnyObject?->AnyObject? = {_ in nil}) {
        (self._to, self._back) = (to, back)
        super.init()
    }
}

@objc public class DictMapper:Mapper {
    var dict:[String:String]
    var backDict:[String:String]
    
    override public func to(t: AnyObject?) -> AnyObject? {
        let d = (t as? NSObject)?.dictionaryWithValuesForKeys(Array(dict.keys))
        return d?.map {[weak self] k,v in (self!.dict[k]!,v)}
    }
    override public func back(u: AnyObject?) -> AnyObject? {
        let d = (u as? NSObject)?.dictionaryWithValuesForKeys(Array(backDict.keys))
        return d?.map {[weak self] k,v in (self!.backDict[k]!,v)}
    }
    public init (dict:[String:String]) {
        self.dict = dict
        self.backDict = dict.map {k,v in (v,k)}
        super.init()
    }
}
