//
//  RustNamedData.swift
//  RustOwnershipPassing
//
//  Created by John Gallagher on 10/8/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

class RustNamedData {
    private let raw: COpaquePointer

    init() {
        raw = named_data_new()
    }

    deinit {
        named_data_destroy(raw)
    }

    var name: String {
        let byteSlice = named_data_get_name(raw)

        // The `!` here assumes Rust is always giving us valid UTF8 strings.
        return byteSlice.asString()!
    }

    var count: Int {
        return named_data_count(raw)
    }
}
