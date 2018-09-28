//
//  HDBipTests.swift
//  Vite-keystore_ExampleTests
//
//  Created by Stone on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
import CryptoSwift
@testable import Vite_keystore

class HDBipTests: XCTestCase {

    func test() {
        let seed = "899b4ee8ce42e2c090f28d3523279e2bdfe6b868b5742f2398db9af26e854d4457f61410ad0dd292e6db75e65efcb2d341ad5e330abb683c60bf7d1c793c463f".hex2Bytes

        let retKey = "f84cdd034c4de6ed4eac92baf99b4d44abb1d55d1e0056ff3a534612069b1a13"
        let retAccounts = ["m/44'/666666'/0' 5e79b6c9d235907f608375911c5bc9f06735c7c32922b99e6c978a1e846308fa  vite_0c27e431629b49fad8fcc87d33123dd70d6a73657c60cd8cb4",
                           "m/44'/666666'/1' fc2869a7abecf8db81f1ca7628376ec7859477221e280cf00b4bb10db3b700ab  vite_9e406fd75463a232f00f5c3bf51d0c49561d6c2ec119ce3f3c",
                           "m/44'/666666'/2' c079e47df8f8bab00cbc89ffc41f19643a4c605bc898bca65843efaee351c03f  vite_bf56e382349867441f1f52ab55661c0ff0786204444fa10ee2",
                           "m/44'/666666'/3' 3185e982bbdf0844ca89c81245aeefef313fbe4b99d86b1ccfb372b1f8f41d53  vite_fb61bb0a65ac4141aeddfa247c808ded1ab4ea53ef10eef644",
                           "m/44'/666666'/4' 789319272afef150af138b5b0be12b997efbae6e4285dbe4cd0296b1d8791614  vite_8cf0c68cea2988d14e30d133baa2b279ccc4b4011263d74bd0",
                           "m/44'/666666'/5' bbb2b0cdb3063759548c77e687bb32e5d3df8609a79063171e50e3509c1bedbf  vite_25b07769690f8e897e0289907a7117d063614c7fe698648e21",
                           "m/44'/666666'/6' 5b6df91139ce51786300aa60e014bd76a2732d95f084f7792f94473adc6394d8  vite_aec7c83a130617fef863723cf731aed0426d45a2227268b1e0",
                           "m/44'/666666'/7' d1d2af696f4a87ed92562b760f714281d0fb02bdc7cfd36f38109c839f3691a6  vite_00b2aed4102dfc97b6a322c73ae1158d024fe5444213ac1a10",
                           "m/44'/666666'/8' ad37d743a20460d08168ce568dd519aeda857dc5fb89143354b7ecf857e932b2  vite_889ba379a0390843fd18f8f89ed8ae268bd2bfdbb48f96c57a",
                           "m/44'/666666'/9' ef37907b74e037ae74d48714ed3587c17779c464ea8a7d6a976d3e9c621471a7  vite_97692d152d969bddaedaddcd58baa996fe913d912b2875c35c",]

        let key = HDBip.masterKey(seed: seed)

        XCTAssertEqual(key?.key.toHexString(), retKey)

        for i in 0..<10 {
            let path = "\(HDBip.viteAccountPrefix)/\(i)'"
            guard let k = HDBip.deriveForPath(path: path, seed: seed) else { fatalError() }
            guard let (seed, address) = k.stringPair() else { fatalError() }
            let account = "\(path) \(seed)  \(address)"
            XCTAssertEqual(account, retAccounts[i])
        }
    }

}
