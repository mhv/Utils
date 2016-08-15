//
//  SparseArray.swift
//  Signal
//
//  Created by Mikhail Vroubel on 07/02/2015.
//
//

import Foundation

// TODO: : Collection
public struct SparseArray<T> : Sequence {
    public init(){}
    public typealias Element = (Int, T)
    public typealias Index = DictionaryIndex<Int, T>
    var indices = NSMutableIndexSet()

    var accessor = [Int: T]()
    public var startIndex: Index {return accessor.startIndex}
    public var endIndex: Index {return accessor.endIndex}
    public subscript (position: Index) -> Element {return accessor[position]}
    
    public func makeIterator() -> AnyIterator<Element> {
        var last = indices.firstIndex
        return AnyIterator {
            let current = last
            last = self.indices.indexGreaterThanIndex(last)
            return current != NSNotFound ? (current, self.accessor[current]!) : nil
        }
    }
    
    public subscript (i idx:Int)->T? {
        get {return accessor[idx]}
        set (value) {
            if let v = value {
                _ = append(v, index: idx)
            } else {
                removeAtIndex(idx)
            }
        }
    }
    
    public mutating func append(_ value:T, index:Int = 0)->Int {
        let next = Swift.max(index, indices.count > 0 ? indices.lastIndex + 1 : 0)
        indices.add(next)
        accessor[next] = value
        return next
    }
    
    public mutating func removeAtIndex(_ index: Int) {
        accessor[index] = nil
        indices.remove(index)
    }
}
