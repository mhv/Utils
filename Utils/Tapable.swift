//
//  Tapable.swift
//  Utils
//
//  Created by Mikhail Vroubel on 8/15/16.
//  Copyright © 2016 Mikhail Vroubel. All rights reserved.
//

import Foundation

public protocol Tapable {}

extension Tapable {
    public mutating func tap( _ block: @noescape (inout Self) -> ()) -> Self {
        block(&self)
        return self
    }
}

extension NSObject: Tapable {}
