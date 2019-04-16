//
//  OnroadTests.swift
//  ViteWallet_Tests
//
//  Created by Stone on 2019/4/8.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ViteWallet
import BigInt
import PromiseKit

class OnroadTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Box.setUp()
        async { (c) in
            Box.f.receiveAll(account: Box.testWallet.firstAccount, c)
        }
    }

    override func tearDown() {
        async { (c) in
            Box.f.receiveAll(account: Box.testWallet.firstAccount, c)
        }
        super.tearDown()
    }

    func testAll() {
        
        async { (c) in
            let address = Box.testWallet.firstAccount.address
            let firstAmount = Balance(value: BigInt("1000000000000000000")!)
            let secondAmount = Balance(value: BigInt("2000000000000000000")!)
            printLog("start")
            Box.f.sendViteToSelf(account: Box.testWallet.firstAccount, amount: firstAmount)
                .then { ret -> Promise<Void> in
                    printLog("send self \(ret.amount!.value.description)")
                    return Promise.value(())
                }.then { () -> Promise<AccountBlock> in
                    return Box.f.sendViteToSelf(account: Box.testWallet.firstAccount, amount: secondAmount)
                }.then { ret -> Promise<Void> in
                    printLog("send self \(ret.amount!.value.description)")
                    return Promise.value(Void())
                }.then { () -> Promise<[AccountBlock]> in
                    return ViteNode.onroad.getOnroadBlocks(address: address, index: 0, count: 10)
                }.then { ret -> Promise<[OnroadInfo]> in
                    XCTAssert(ret.count == 2)
                    let first = ret[0]
                    let second = ret[1]
                    XCTAssert(first.amount?.value == firstAmount.value)
                    XCTAssert(second.amount?.value == secondAmount.value)
                    return ViteNode.onroad.getOnroadInfos(address: address)
                }.done { ret in
//                    XCTAssert(ret.count == 1)
//                    let info = ret[0]
//                    XCTAssert(info.unconfirmedCount == 2)
//                    XCTAssert(info.unconfirmedBalance.value == (firstAmount.value + secondAmount.value))
                }.catch { (error) in
                    printLog(error)
                    XCTAssert(false)
                }.finally {
                    printLog("end")
                    c()
            }
        }
    }
}