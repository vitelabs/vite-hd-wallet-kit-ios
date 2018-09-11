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

public class WalletStorage {
    public static let shareInstance = WalletStorage()

    let keychain = KeychainSwift.init(keyPrefix: "vite")


    private let defaultKeychainAccess: KeychainSwiftAccessOptions = .accessibleAlways
    private let walletAccountsKey = "walletAccounts"
    public var walletAccounts:[WalletAccount] = []

    init() {
        keychain.synchronizable = true
        fetch()
    }

    public func fetch() {
        var data =  keychain.get(walletAccountsKey)
        if (data == nil || (data?.isEmpty)!) {
            walletAccounts = []
        }else{
            var walletAccount = Mapper<WalletAccount>().mapArray(JSONString: data!)
            walletAccounts = walletAccount!
        }
    }
    public func update(account: WalletAccount) {
        handleWalletByAccount(replace: account)

        keychain.set(walletAccounts.toJSONString()!, forKey: walletAccountsKey, withAccess:defaultKeychainAccess)

    }

    public func add(account: WalletAccount){
        walletAccounts.append(account)
        keychain.set(walletAccounts.toJSONString()!, forKey: walletAccountsKey, withAccess:defaultKeychainAccess)
    }

    public func delete(account: WalletAccount) {
        delWalletByAccount(del: account)
        keychain.set(walletAccounts.toJSONString()!, forKey: walletAccountsKey, withAccess:defaultKeychainAccess)
    }

    func handleWalletByAccount(replace: WalletAccount)  {
        walletAccounts.map {  (account) -> WalletAccount in
            if (account.mnemonic == replace.mnemonic){
                return replace
            }else{
                return account
            }
        }
    }

    func delWalletByAccount(del: WalletAccount)  {
        walletAccounts.filter { (account) -> Bool in
            if (account.mnemonic == del.mnemonic){
                return false
            }else{
                return true
            }
        }
    }
}
