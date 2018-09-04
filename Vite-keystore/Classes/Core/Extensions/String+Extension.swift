//
//  String+Extension.swift
//  Vite-keystore
//
//  Created by Water on 2018/8/31.
//

import Foundation

fileprivate var kHexPrefix = "0x"

extension String {
    //二进制 字符串 头部处理
    public func stripHexPrefix() -> String {
        var hex = self
        if hex.hasPrefix(kHexPrefix) {
            hex = String(hex.dropFirst(kHexPrefix.count))
        }
        return hex
    }

    public func addHexPrefix() -> String {
        return kHexPrefix.appending(self)
    }

    public func toHexString() -> String {
        guard let data = data(using: .utf8) else {
            return ""
        }
        return data.toHexString()
    }
}

