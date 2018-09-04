//
//  KeystoreInterface.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import Foundation

public enum KeystoreError: Error {
    case keyDerivationError
    case aesError
}

protocol KeystoreInterface {
    func getDecriptedKeyStore(password: String) throws -> Data?
    func encodedData() throws -> Data
    init? (seed: Data, password: String) throws
    init? (keyStore: Data) throws
}
