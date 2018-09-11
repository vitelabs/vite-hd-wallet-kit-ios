//
//  WalletAccount.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//

import Foundation
import ObjectMapper

public struct WalletAccount : Mappable{

    public var mnemonic = ""
    public var password = ""
    public var name = ""
    public var isSwitchTouchId = false
    public var existAddressIndex = [0]
    public var defaultAddressIndex = 0

    public init() {

    }

    public init?(map: Map) {

    }

    public mutating func mapping(map: Map) {
        mnemonic    <- map["mnemonic"]
        password    <- map["password"]
        name    <- map["name"]
        isSwitchTouchId    <- map["isSwitchTouchId"]
        existAddressIndex    <- map["existAddressIndex"]
        defaultAddressIndex    <- map["defaultAddressIndex"]
    }
}
