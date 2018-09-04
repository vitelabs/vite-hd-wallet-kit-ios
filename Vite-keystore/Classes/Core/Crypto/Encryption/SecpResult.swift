//
//  SecpResult.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import Foundation

enum SecpResult {
    case success
    case failure
    
    init(_ result:Int32) {
        switch result {
        case 1:
            self = .success
        default:
            self = .failure
        }
    }
}
