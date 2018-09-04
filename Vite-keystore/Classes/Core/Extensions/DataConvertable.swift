//
//  DataConvertable.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//

import Foundation

protocol DataConvertable {
    static func +(lhs: Data, rhs: Self) -> Data
    static func +=(lhs: inout Data, rhs: Self)
}

extension UInt8: DataConvertable {}
extension UInt32: DataConvertable {}

extension DataConvertable {
    static func +(lhs: Data, rhs: Self) -> Data {
        var value = rhs
        let data = Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
        return lhs + data
    }

    static func +=(lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
}

