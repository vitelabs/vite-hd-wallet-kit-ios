//
//  WalletStorage.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//

import Foundation
import KeychainSwift
import ObjectMapper

public class WalletStorage: NSObject {

    let keychain = KeychainSwift.init(keyPrefix: "vite")

    private let defaultKeychainAccess: KeychainSwiftAccessOptions = .accessibleAlways
    private let walletAccountsKey = "walletAccounts"
    public var walletAccounts: [WalletAccount] = []

    public override  init() {
        super.init()
        keychain.synchronizable = true
        self.fetch()
    }

    public func fetch() {
        let data =  keychain.get(walletAccountsKey)
        if (data == nil || (data?.isEmpty)!) {
            walletAccounts = []
        } else {
            let walletAccount = Mapper<WalletAccount>().mapArray(JSONString: data!)
            walletAccounts = walletAccount!
        }
    }

    public func login(replace: WalletAccount) {
        for (index, item) in walletAccounts.enumerated() {
            if (item.mnemonic == replace.mnemonic) {
                walletAccounts.remove(at: index)
                walletAccounts.insert(replace, at: 0)
                return
            }
        }
    }

    public func isExist(_ accout: WalletAccount) ->(Bool){
        for (index, item) in walletAccounts.enumerated() {
            if (item.mnemonic == accout.mnemonic) {
                return true
            }
        }
        return false
    }

    public func update(account: WalletAccount) {
        handleWalletByAccount(replace: account)
        self.storeAllWallets()
    }

    public func add(account: WalletAccount) {
        walletAccounts.append(account)
        self.storeAllWallets()
    }

    public func delete(account: WalletAccount) {
        delWalletByAccount(del: account)
        self.storeAllWallets()
    }

    public func storeAllWallets() {
        keychain.set(walletAccounts.toJSONString()!, forKey: walletAccountsKey, withAccess: defaultKeychainAccess)
    }

    func handleWalletByAccount(replace: WalletAccount) {
       _ = walletAccounts.map {  (account) -> WalletAccount in
            if (account.mnemonic == replace.mnemonic) {
                return replace
            } else {
                return account
            }
        }
    }

    func delWalletByAccount(del: WalletAccount) {
        _ = walletAccounts.filter { (account) -> Bool in
            if (account.mnemonic == del.mnemonic) {
                return false
            } else {
                return true
            }
        }
    }

    public func delAllWallet () {
        walletAccounts = []
        storeAllWallets()
    }
}
