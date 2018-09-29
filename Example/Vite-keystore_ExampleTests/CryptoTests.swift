//
//  CryptoTests.swift
//  Vite-keystore_ExampleTests
//
//  Created by Water on 2018/9/21.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
import CryptoSwift
@testable import Vite_HDWalletKit

class CryptoTests: XCTestCase {
    func testSHA3Keccak256() {
        let data = "Hello".data(using: .utf8)!
        let encrypted = Crypto.sha3keccak256(data)
        XCTAssertEqual(encrypted.toHexString(), "06b3dfaec148fb1bb2b066f10ec285e7c9bf402ab32aa78a5d38e34566810cd2")
    }

    func testEthereumAddress() {
        XCTAssertEqual(EthereumAddress.isValid(string: "jello"), false)
        XCTAssertEqual(EthereumAddress.isValid(string: "0xCe20A458f37eA8EA288b1C6bf83BbC387862Fd2d"), true)
        XCTAssertEqual(EthereumAddress.isValid(string: "0xCe20A458f37eA8EA288b1C6bf8387862Fd2d"), false)
        XCTAssertEqual(EthereumAddress.isValid(string: "0xCe20A458f37eA8EA288b1C6bf83BDDDDDbC387862Fd2d"), false)
        XCTAssertEqual(EthereumAddress.isValid(string: "0xCe20A458f37eA8EA288b1C6bf8ppp3BbC387862Fd2d"), false)
    }


}
