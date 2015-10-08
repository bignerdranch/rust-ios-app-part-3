//
//  SwiftObject.swift
//  RustOwnershipPassing
//
//  Created by John Gallagher on 10/8/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

class SwiftObject {
    deinit {
        print("SwiftObject being deallocated")
    }

    private func callbackWithArg(arg: Int) {
        print("SwiftObject: received callback with arg \(arg)")
    }

    func sendToRust() {
        let ownedPointer = UnsafeMutablePointer<Void>(Unmanaged.passRetained(self).toOpaque())
        let wrapper = swift_object(
            user: ownedPointer,
            destroy: destroy,
            callback_with_int_arg: callback_with_int_arg)
        give_object_to_rust(wrapper)
    }
}

private func callback_with_int_arg(user: UnsafeMutablePointer<Void>, arg: Int32) {
    let obj: SwiftObject = Unmanaged.fromOpaque(COpaquePointer(user)).takeUnretainedValue()
    obj.callbackWithArg(Int(arg))
}

private func destroy(user: UnsafeMutablePointer<Void>) {
    let _ = Unmanaged<SwiftObject>.fromOpaque(COpaquePointer(user)).takeRetainedValue()
}
