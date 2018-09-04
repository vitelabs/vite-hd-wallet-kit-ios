//
//  Data+Extension.swift
//  Vite-keystore
//
//  Created by Water on 2018/8/31.
//

import Foundation

extension Data {

    //使用iOS 系统函数 SecRandomCopyBytes 生成一个安全的随机数字。
    static func randomBytes(length: Int) -> Data {
        var bytes = Data(count: length)
        _ = bytes.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, length, $0) }
        return bytes
    }


    public func dataToHexString() -> String {
        return map { String(format: "%02x", $0) }.joined()
    }

    public static func fromHex(_ hex: String) -> Data? {
        let string = hex.lowercased().stripHexPrefix()
        let array = Array<UInt8>(hex: string)
        if (array.count == 0) {
            if (hex == "0x" || hex == "") {
                return Data()
            } else {
                return nil
            }
        }
        return Data(array)
    }

    public func constantTimeComparisonTo(_ other:Data?) -> Bool {
        guard let rhs = other else {return false}
        guard self.count == rhs.count else {return false}
        var difference = UInt8(0x00)
        for i in 0..<self.count { // compare full length
            difference |= self[i] ^ rhs[i] //constant time
        }
        return difference == UInt8(0x00)
    }
}



