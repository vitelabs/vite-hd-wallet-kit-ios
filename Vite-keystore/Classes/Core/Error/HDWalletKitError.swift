//
//  HDWalletKitError.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import Foundation

public enum HDWalletKitError: Error {
    public enum CryptoError {
        case failedToEncode(element:Any)
    }
    
    case cryptoError(CryptoError)
    case failedToSign
    case unknownError
}
