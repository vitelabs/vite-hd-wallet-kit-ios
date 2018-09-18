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
@testable import libEd25519Blake2b

class HDBipTests: XCTestCase {

    func test() {
        let seed = "899b4ee8ce42e2c090f28d3523279e2bdfe6b868b5742f2398db9af26e854d4457f61410ad0dd292e6db75e65efcb2d341ad5e330abb683c60bf7d1c793c463f".hex2Bytes

        let retKey = "f84cdd034c4de6ed4eac92baf99b4d44abb1d55d1e0056ff3a534612069b1a13"
        let retAccounts = ["m/44'/999'/0' 4495f8ac7466a4bad825d3c1741e514baa41ce7c413bedcdd24c138e104b6934  vite_4475f6dd2fa87d372dbad4f708e5c389a6856b53c183cf5bb6",
                           "m/44'/999'/1' 66655a25a6713e39be5224dd7903649c4a7ca328b3e563d44875bd138ce612c9  vite_6e149f83f468b51c56b50078dec1898bfaa33b10f06c3a6309",
                           "m/44'/999'/2' eef125116fc40628d67f5b89a7ce96a34554432f7ff697f2beb92025a1c6522e  vite_0a1a68984db218ff672ce359c6ab9c4dbbd3e0c363ec234cc7",
                           "m/44'/999'/3' 1abe5c297e1b32b3521538e61108602c75a50887da39720feaf8949fb953e213  vite_07848cf142eb84d0ac6ba547773cfbcde3fe904b59b09542d5",
                           "m/44'/999'/4' da66f0f3a2ecf51ee0983e99d73fce990b5526135149c4436f4c3d2d7f7a99c7  vite_91a8a48bf824209ee38e90f0154014083bb2e85f17a9c88184",
                           "m/44'/999'/5' 3eaa5490e0d5980511219067a63d5572e27e671a9d33d63efc540b2c2485d057  vite_21b29b8321953949a54daa747f705944888e98e3460a6f875a",
                           "m/44'/999'/6' c245393ead655eda745515ab9c52e81a739d2373b89a1b1fda41b3d43675868a  vite_946b161b8c6dca7883ce8e9f5a36b8c3091014a08fe7b988ac",
                           "m/44'/999'/7' 6f96308b64e03858b8f0a2b00e5d83b91f38418b7c4cc31bfcf1dcf7e4498f32  vite_b300b5f2511a4261314a0a5f5bca8bab3a211234f846ed3361",
                           "m/44'/999'/8' 9af654ce607d6b89c89b4d1128b421fbbb320a1e4c58299917645359b3e0e265  vite_49a8f97fabc63604ef7c9d5d03eddb11cc45e1a3888c914373",
                           "m/44'/999'/9' 1463cbb2f8aa501f6948bee523df0f3309305fc0a92e9f730fe02be38cff78bb  vite_b0a24240859b78896bd3ff7618d6c1a829b4b673e996ee6f67"]

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
