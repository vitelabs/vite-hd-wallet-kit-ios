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

    public var uuid = UUID().uuidString
    public var mnemonic = ""
    public var password = ""
    public var name = ""

    //iphone touchId switch
    public var isSwitchTouchId = false

    //account is or not login, in order to use it
    public var isLogin = false

    public init() {

    }

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        uuid    <- map["uuid"]
        mnemonic    <- map["mnemonic"]
        password    <- map["password"]
        name    <- map["name"]
        isSwitchTouchId    <- map["isSwitchTouchId"]
        isLogin    <- map["isLogin"]
    }
}
