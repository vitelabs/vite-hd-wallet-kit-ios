//
//  Account.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import Foundation

public struct Account {
    
    public init(privateKey: PrivateKey) {
        self.privateKey = privateKey
    }
    
    public let privateKey: PrivateKey
    
    public var rawPrivateKey: String {
        return privateKey.get()
    }
    
    public var rawPublicKey: String {
        return privateKey.publicKey.get()
    }
    
    public var address: String {
        return privateKey.publicKey.address
    }
}
