//
//  WalletAccount.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//

import Foundation
import ObjectMapper

public class WalletAccount : Mappable{

    public var mnemonic = ""
    public var password = ""
    public var name = ""
    public var isSwitchTouchId = false
    public var addressCount = 1 {
        didSet {
            existKeys = generateExistKeys()
        }
    }
    public var defaultAddressIndex = 0

    public init() {

    }

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        mnemonic    <- map["mnemonic"]
        password    <- map["password"]
        name    <- map["name"]
        isSwitchTouchId    <- map["isSwitchTouchId"]
        addressCount    <- map["addressCount"]
        defaultAddressIndex    <- map["defaultAddressIndex"]
    }

    public lazy var existKeys: [Key] = self.generateExistKeys()
    public var defaultKey: Key { return existKeys[defaultAddressIndex] }
}

extension WalletAccount {
    public struct Key {
        public var secretKey: String
        public var publicKey: String
        public var address: String
    }

    public var canGenerateAddress: Bool {
        return addressCount < 10
    }

    public func generateAddress() {
        if canGenerateAddress {
            addressCount += 1
            // TODO: need to save
        }
    }

    public func setDefaultAddressIndex(_ index: Int) {
        if index < addressCount {
            defaultAddressIndex = index
        }
    }

    fileprivate func generateExistKeys() -> [Key] {
        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic).toHexString()
        let keys = NSMutableArray()
        for index in 0..<addressCount {
            let path = "\(HDBip.viteAccountPrefix)/\(index-1)'"
            if let (secretKey, publicKey, address) = HDBip.accountsForIndex(index, seed: seed) {
                let key = Key(secretKey: secretKey, publicKey: publicKey, address: address)
                keys.add(key)
            }
        }
        return keys as! Array<Key>
    }
}
