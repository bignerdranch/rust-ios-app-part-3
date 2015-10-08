//
//  RustByteSlice.swift
//  RustOwnershipPassing
//
//  Created by John Gallagher on 10/8/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

extension RustByteSlice {
    func asUnsafeBufferPointer() -> UnsafeBufferPointer<UInt8> {
        return UnsafeBufferPointer(start: bytes, count: len)
    }

    func asString(encoding: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        return String(bytes: asUnsafeBufferPointer(), encoding: encoding)
    }
}
