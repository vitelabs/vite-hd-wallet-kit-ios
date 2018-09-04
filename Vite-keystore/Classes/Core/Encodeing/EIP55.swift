//
//  EIP55.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import CryptoSwift

// NOTE: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md
public struct EIP55 {
    public static func encode(_ data: Data) -> String {
        let address = data.toHexString()
        
        let hash = Crypto.sha3keccak256(data: address.data(using: .ascii)!).toHexString()
        
        return zip(address, hash)
            .map { a, h -> String in
                switch (a, h) {
                case ("0", _), ("1", _), ("2", _), ("3", _), ("4", _), ("5", _), ("6", _), ("7", _), ("8", _), ("9", _):
                    return String(a)
                case (_, "8"), (_, "9"), (_, "a"), (_, "b"), (_, "c"), (_, "d"), (_, "e"), (_, "f"):
                    return String(a).uppercased()
                default:
                    return String(a).lowercased()
                }
            }
            .joined()
    }
}

