//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//



import CryptoSwift

public struct EIP155Signer {
    
    private let chainID: Int = 1
    

    public func calculateRSV(signature: Data) -> (r: BInt, s: BInt, v: BInt) {
        return (
            r: BInt(str: signature[..<32].toHexString(), radix: 16)!,
            s: BInt(str: signature[32..<64].toHexString(), radix: 16)!,
            v: BInt(signature[64]) + 35 + 2 * chainID
        )
    }

    public func calculateSignature(r: BInt, s: BInt, v: BInt) -> Data {
        let isOldSignatureScheme = [27, 28].contains(v)
        let suffix = isOldSignatureScheme ? v - 27 : v - 35 - 2 * chainID
        let sigHexStr = hex64Str(r) + hex64Str(s) + suffix.asString(withBase: 16)
        return Data(hex: sigHexStr)
    }

    private func hex64Str(_ i: BInt) -> String {
        let hex = i.asString(withBase: 16)
        return String(repeating: "0", count: 64 - hex.count) + hex
    }
}
