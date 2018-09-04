//
//  Network.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


public enum Network {
    case main(Coin)
    case test(Coin)

    public var privateKeyVersion: UInt32 {
        switch self {
        case .main:
            return 0x0488ADE4
        case .test:
            return 0x04358394
        }
    }
    
    public var publicKeyVersion: UInt32 {
        switch self {
        case .main:
            return 0x0488B21E
        case .test:
            return 0x043587CF
        }
    }

    public var publicKeyHash: UInt8 {
        switch self {
        case .main(let coin):
            switch coin {
            case .litecoin:
                return 0x30
            default:
                return 0x00
            }
        case .test:
            return 0x6f
        }
    }
    
    public var addressPrefix:String {
        switch self {
        case .main(let coin):
            switch coin {
            case .ethereum:
                return "0x"
            case .vite:
                return "vite_"
            default:
                return ""
            }
        case .test(let coin):
            switch coin {
            case .ethereum:
                return "0x"
            case .vite:
                return "vite_"
            default:
                return ""
            }
        }
    }
    
    public var coin: Coin {
        switch self {
        case .main(let coin):
            return coin
        case .test(let coin):
            return coin
        }
    }

    
    public var coinType: UInt32 {
        switch self {
        case .main(let type):
            switch type {
            case .bitcoin:
                return 0
            case .ethereum:
                return 60
            case .litecoin:
                return 2
            case .bitcoinCash:
                return 145
            case .vite:
                return 60
            }
        case .test:
            return 1
        }
    }
}
