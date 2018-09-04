//
//  Mnemonic.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import Foundation

// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki

//https://iancoleman.io/bip39/  使用该网站验证结果
public final class Mnemonic {
    //密码强度
    public enum Strength: Int {
        case weak = 128    //12 个单词
        case strong = 256  //24 个单词
    }

    //随机生成密码本
    public static func randomGenerator(strength: Strength = .weak, language: MnemonicCodeBook = .english) -> String {
        let byteCount = strength.rawValue  / 8
        let bytes = Data.randomBytes(length: byteCount)   //随机生成一个熵

        let str = bytes.toHexString()
        return generator(entropy: bytes, language: language)
    }

    //根据data 生成助记词
    public static func generator(entropy: Data, language: MnemonicCodeBook = .english) -> String {
        precondition(entropy.count % 4 == 0 && entropy.count >= 16 && entropy.count <= 32)

        let entropybits = String(entropy.flatMap { ("00000000" + String($0, radix: 2)).suffix(8) })
        let hashBits = String(entropy.sha256().flatMap { ("00000000" + String($0, radix: 2)).suffix(8) })
        let checkSum = String(hashBits.prefix((entropy.count * 8) / 32))
        
        let words = language.words
        let concatenatedBits = entropybits + checkSum
        
        var mnemonic: [String] = []
        for index in 0..<(concatenatedBits.count / 11) {
            let startIndex = concatenatedBits.index(concatenatedBits.startIndex, offsetBy: index * 11)
            let endIndex = concatenatedBits.index(startIndex, offsetBy: 11)
            let wordIndex = Int(strtoul(String(concatenatedBits[startIndex..<endIndex]), nil, 2))

            mnemonic.append(String(words[wordIndex]))
        }
        
        return mnemonic.joined(separator: " ")
    }

    //BIP39 Seed
    public static func createBIP39Seed(mnemonic: String, withPassphrase passphrase: String = "") -> Data {
        precondition(passphrase.count <= 256, "Password too long")

        //助记词
        guard let password = mnemonic.decomposedStringWithCompatibilityMapping.data(using: .utf8) else {
            fatalError("Nomalizing password failed in \(self)")
        }
        //密码加盐
        guard let salt = ("mnemonic" + passphrase).decomposedStringWithCompatibilityMapping.data(using: .utf8) else {
            fatalError("Nomalizing salt failed in \(self)")
        }
        
        return Crypto.PBKDF2SHA512(password: password.bytes, salt: salt.bytes)
    }
}

