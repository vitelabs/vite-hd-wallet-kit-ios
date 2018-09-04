//
//  AppDelegate.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import UIKit
import Vite_keystore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let numbers = [1, 2, 6, 4, 50,1]
        print(numbers.suffix(2))

        let str = Mnemonic.randomGenerator(strength: .strong, language: .english)

        let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
        let mnemonic = Mnemonic.generator(entropy: entropy)
        let mnemonic_zh = Mnemonic.generator(entropy: entropy,language:.simplifiedChinese)
        let mnemonic_zh1 = Mnemonic.generator(entropy: entropy,language:.traditionalChinese)


        let rootVC = ViewController()
        window = UIWindow.init(frame:UIScreen.main.bounds)
        let nav = UINavigationController.init(rootViewController: rootVC)

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
   
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}
