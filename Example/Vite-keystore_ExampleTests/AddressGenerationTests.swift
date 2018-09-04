//
//  AddressGenerationTests.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import XCTest
@testable import Vite_keystore
@testable import CryptoSwift

class AddressGenerationTests: XCTestCase {
    let entropy = Data(hex: "6cdc79301fa3f99267043e3e75e4f65d")
    var mnemonic = ""
    var  seed = Data.init()

    var network = Network.main(.bitcoin)
    var privateKey = PrivateKey.init(seed: Data.init(), network:Network.main(.bitcoin))

    let password = "123456"

    override func setUp() {
        super.setUp()
        mnemonic = Mnemonic.generator(entropy: entropy)
        seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        privateKey = PrivateKey(seed: seed, network: network)
    }

    override func tearDown() {
        super.tearDown()

    }

   func testMainNetChildKeyDerivation() {
      XCTAssertEqual(
         privateKey.extended,
         "xprv9s21ZrQH143K3M9T3SZXT1JY1XTvm1HY2BnAFPmtoPWrqaCzSDpsCQsA7cdHEyPYef5AdxxAatxkiVN8PHynPCHi5DvP5bd4LBUeLbbpz1B"
      )

      //m / purpose' / coin_type' / account' / change / address_index
      // BIP44 key derivation
      // m/44'
      let purpose = privateKey.derived(at: .hardened(44))
      
      // m/44'/0'
      let coinType = purpose.derived(at: .hardened(0))
      
      // m/44'/0'/0'
      let account = coinType.derived(at: .hardened(0))
      
      // m/44'/0'/0'/0
      let change = account.derived(at: .notHardened(0))
      
      XCTAssertEqual(
         change.extended,
         "xprvA1fFDYmerJ1gP8qPX4GRCi9tNhHRnvu1sgtAWLtVjKKpuD3fdb7GbhDAUVBDe8Qox6fHFwTPi9UHP168ScvaR1byCkRUDJspkGMCq7kGcNK"
      )
      
      XCTAssertEqual(
         change.publicKey.extended,
         "xpub6Eebd4JYgfZybcurd5oRZr6cvj7vCPcsEuomJjJ7Heron1NpB8RX9VXeKmAdXu5PpZdsvWD1mDU1ubv42AF8nHtmmjZWezEigv6mjvidXxd"
      )
      
      // m/44'/0'/0'/0/0
      let firstPrivateKey = change.derived(at: .notHardened(0))
      XCTAssertEqual(
         firstPrivateKey.publicKey.address,
         "14qy7SQMsHCj9JbW5o9fhCmKcf7VmEoGiu"
      )
      
      XCTAssertEqual(
         firstPrivateKey.publicKey.raw.toHexString(),
         "02568d09f7c4946a38712cf3a89479f5f6ad79996f07bd81d9f4679b7a5174d3f5"
      )
}
   
   func testTestnetChildKeyDerivation() {
      XCTAssertEqual(
         privateKey.extended,
         "xprv9s21ZrQH143K3M9T3SZXT1JY1XTvm1HY2BnAFPmtoPWrqaCzSDpsCQsA7cdHEyPYef5AdxxAatxkiVN8PHynPCHi5DvP5bd4LBUeLbbpz1B"
      )
      
      // BIP44 key derivation
      // m/44'
      let purpose = privateKey.derived(at:.hardened(44))
      
      // m/44'/0'
      let coinType = purpose.derived(at: .hardened(network.coinType) )
      
      // m/44'/0'/0'
      let account = coinType.derived(at: .hardened(0))
      
      // m/44'/0'/0'/0
      let change = account.derived(at: .notHardened(0))
      
      XCTAssertEqual(
         change.extended,
         "xprvA1fFDYmerJ1gP8qPX4GRCi9tNhHRnvu1sgtAWLtVjKKpuD3fdb7GbhDAUVBDe8Qox6fHFwTPi9UHP168ScvaR1byCkRUDJspkGMCq7kGcNK"
      )
      
      XCTAssertEqual(
         change.publicKey.extended,
         "xpub6Eebd4JYgfZybcurd5oRZr6cvj7vCPcsEuomJjJ7Heron1NpB8RX9VXeKmAdXu5PpZdsvWD1mDU1ubv42AF8nHtmmjZWezEigv6mjvidXxd"
      )
      
      // m/44'/0'/0'/0
      let firstPrivateKey = change.derived(at: .notHardened(0))
      XCTAssertEqual(
         firstPrivateKey.publicKey.address,
         "14qy7SQMsHCj9JbW5o9fhCmKcf7VmEoGiu"
      )
      
      XCTAssertEqual(
         firstPrivateKey.publicKey.raw.toHexString(),
         "02568d09f7c4946a38712cf3a89479f5f6ad79996f07bd81d9f4679b7a5174d3f5"
      )
   }
   
   func testBitcoinMainNetAddressGeneration() {
      let wallet = Wallet(seed: seed, network: .main(.bitcoin))
      
      let firstAddress = wallet.generateAddress(at: 0)
      XCTAssertEqual(firstAddress, "14qy7SQMsHCj9JbW5o9fhCmKcf7VmEoGiu")
      
      let secondAddress = wallet.generateAddress(at: 1)
      XCTAssertEqual(secondAddress, "19MQJEw4BHDpDXLZqJn3qs1hZgZfGD47Zu")
      
      let thirdAddress = wallet.generateAddress(at: 2)
      XCTAssertEqual(thirdAddress, "1A62UEzEL5mgW3q3UjTYSAg9kHT3SACZyd")
      
      let forthAddress = wallet.generateAddress(at: 3)
      XCTAssertEqual(forthAddress, "1bAhNLzJ9QJoaCUaXK5m7jHLaQ2LMK3qJ")
      
   }
   
   func testBitcoinTestNetAddressGeneration() {
      let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
      let mnemonic = Mnemonic.generator(entropy: entropy)
      let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
      let wallet = Wallet(seed: seed, network: .test(.bitcoin))
      
      let firstAddress = wallet.generateAddress(at: 0)
      XCTAssertEqual(firstAddress, "mq1VMMXiZKLdY2WLeaqocJxXijhEFoQu3X")
      
      let secondAddress = wallet.generateAddress(at: 1)
      XCTAssertEqual(secondAddress, "mu7gEKi6LWdWTMdEpux3v79huagEZFMJBN")
      
      let thirdAddress = wallet.generateAddress(at: 2)
      XCTAssertEqual(thirdAddress, "mhDiBvv9fo4pUrDiC4wLS1gS8x9EBuvagg")
      
      let forthAddress = wallet.generateAddress(at: 3)
      XCTAssertEqual(forthAddress, "mqwDZupDkKsaLsEEDAC9yKtQW6AFTsNeCh")
      
   }
   
   func testLitecoinAddressGeneration() {
      let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
      let mnemonic = Mnemonic.generator(entropy: entropy)
      let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
      let wallet = Wallet(seed: seed, network: .main(.litecoin))
      
      let firstAddress = wallet.generateAddress(at: 0)
      XCTAssertEqual(firstAddress, "LV8fThzQw45HT6bCgs1yfvLNzv4aFvjJt1")
      
      let secondAddress = wallet.generateAddress(at: 1)
      XCTAssertEqual(secondAddress, "Lg7bkp36nPJdqoYAfpmR1UUdXgSq9iCxBX")
      
      let thirdAddress = wallet.generateAddress(at: 2)
      XCTAssertEqual(thirdAddress, "LRajgVNRke9ttvrnncpH52iNAbCFdSxq2b")
      
      let forthAddress = wallet.generateAddress(at: 3)
      XCTAssertEqual(forthAddress, "LcZoNSHLQc1XGjMLy6PdqE8PtphMbRPCQ3")
   }
   
   func testBitcoinCashAddressGeneration() {
      let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
      let mnemonic = Mnemonic.generator(entropy: entropy)
      let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
      let wallet = Wallet(seed: seed, network: .main(.bitcoinCash))
      
      let firstAddress = wallet.generateAddress(at: 0)
      XCTAssertEqual(firstAddress, "1FYh9oXWbAzgcX3hPSrRWUodYWt87bMmne")
      
      let secondAddress = wallet.generateAddress(at: 1)
      XCTAssertEqual(secondAddress, "19Q2M5swtorWmL9ZdhtaxBFFuhUuBr9z1Q")
      
      let thirdAddress = wallet.generateAddress(at: 2)
      XCTAssertEqual(thirdAddress, "1QDAX8eZXMjVdZxMzHyXr81uWu9ZDWd9vR")
      
      let forthAddress = wallet.generateAddress(at: 3)
      XCTAssertEqual(forthAddress, "1Jgjm6m4ETPGezaoTBdJCJV7RCjDRR9Ddf")
   }
   
   func testBitcoinMainNetAccountGeneration() {
      let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
      let mnemonic = Mnemonic.generator(entropy: entropy)
      let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
      let network: Network = .main(.bitcoin)
      let wallet = Wallet(seed: seed, network: network)
      let privateKey0 = bip44PrivateKey(network: network, from:wallet.privateKey).derived(at: .notHardened(0))
      let privateKey1 = bip44PrivateKey(network: network, from:wallet.privateKey).derived(at: .notHardened(1))
      let accounts:[String] = [Account(privateKey: privateKey0),
                               Account(privateKey: privateKey1)].compactMap { (account) -> String in
                                 return account.address
      }
      let generatedAccounts:[String] = wallet.generateAccounts(count: 2).compactMap { (account) -> String in
         return account.address
      }
      XCTAssertEqual(generatedAccounts, accounts)
      
   }
   
   func bip44PrivateKey(network: Network , from: PrivateKey) -> PrivateKey {
      let bip44Purpose:UInt32 = 44
      let purpose = from.derived(at: .hardened(bip44Purpose))
      let coinType = purpose.derived(at: .hardened(network.coinType))
      let account = coinType.derived(at: .hardened(0))
      let receive = account.derived(at: .notHardened(0))
      return receive
   }
}
