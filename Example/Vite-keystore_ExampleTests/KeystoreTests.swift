//
//  KeystoreTests.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import XCTest
@testable import Vite_keystore

class KeystoreTests: XCTestCase {
    
    func testKeyStoreGeneration() {
        let data = Data(hex: "576896308291575cb5b61eacd178e19721736b63594ee4c9bf60ffd9f3bd869de2124580d9ef0d4446fe467a7014b9894a738780db3c00cde5f86a7922115bdb")
        let keystore = try! KeystoreV3(seed: data, password: "bYSqu6{X")
        XCTAssertEqual(keystore?.keystoreParams?.crypto.cipher, "aes-128-ctr")
        XCTAssertEqual(keystore?.keystoreParams?.crypto.kdf, "scrypt")
        XCTAssertEqual(keystore?.keystoreParams?.crypto.kdfparams.r, 8)
        XCTAssertEqual(keystore?.keystoreParams?.crypto.kdfparams.p, 1)
        XCTAssertEqual(keystore?.keystoreParams?.crypto.kdfparams.n, 1024)
        XCTAssertEqual(keystore?.keystoreParams?.crypto.kdfparams.dklen, 32)
    }
    
    func testDecodeKeystore() {
        let data = Data(hex: "576896308291575cb5b61eacd178e19721736b63594ee4c9bf60ffd9f3bd869de2124580d9ef0d4446fe467a7014b9894a738780db3c00cde5f86a7922115bdb")
        let password = "bYSqu6{X"
        let keystore = try! KeystoreV3(seed: data, password: password)
        guard let decoded = try? keystore?.getDecriptedKeyStore(password: password) else {
            assertionFailure()
            fatalError()
        }
        XCTAssertEqual(decoded, data)
    }
    
    
}
