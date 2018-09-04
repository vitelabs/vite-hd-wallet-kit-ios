//
//  DailyCashViewController.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//
import UIKit
import SnapKit
import Vite_keystore

class DailyCashViewController: UIViewController {
    var keysDirectory: URL
//    var keyStore: KeyStore
    let password = "123456"

    private let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    var createBtn = UIButton()
    var importBtn = UIButton()

    init() {
        self.keysDirectory = URL(fileURLWithPath: datadir + "/keystore")
//        self.keyStore = try! KeyStore(keyDirectory: keysDirectory)

        super.init(nibName:nil, bundle:nil)
    }
    required init?(coder aDecoder: NSCoder) {
        self.keysDirectory = URL(fileURLWithPath: datadir + "/keystore")
//        self.keyStore = try! KeyStore(keyDirectory: keysDirectory)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        createBtn.setTitle("创建钱包", for: .normal)
        createBtn.setTitleColor(.black, for: .normal)
        createBtn.backgroundColor = .orange
        createBtn.addTarget(self, action: #selector(creatAction), for: .touchUpInside)
        self.view.addSubview(createBtn)
        createBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.left.equalTo(self.view).offset(20)
            make.top.equalTo(self.view).offset(100)
        }

        importBtn.setTitle("导入钱包", for: .normal)
        importBtn.setTitleColor(.black, for: .normal)
        importBtn.backgroundColor = .orange
        importBtn.addTarget(self, action: #selector(importAction), for: .touchUpInside)
        self.view.addSubview(importBtn)
        importBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func creatAction() {
//        let path = Config.current.servers.map { $0.derivationPath(at: 0) }
//        let wallet = try! keyStore.createWallet(
//            password: password,
//            derivationPaths: path
//        )
    }

    @objc func importAction(){

    }
}
