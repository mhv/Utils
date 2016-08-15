//
//  Tapable.swift
//  Utils
//
//  Created by Mikhail Vroubel on 8/15/16.
//  Copyright © 2016 Mikhail Vroubel. All rights reserved.
//

import Foundation

public protocol Tapable:class {}

extension Tapable {
    public func tap( _ block: @noescape (Self) -> ()) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Tapable {}
