//
//  ViewController.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//


import UIKit
import SnapKit
import Vite_keystore

class ViewController: UIViewController {
    let walletManageBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        walletManageBtn.setTitle("钱包管理", for: .normal)
        walletManageBtn.setTitleColor(.black, for: .normal)
        walletManageBtn.backgroundColor = .orange
        walletManageBtn.addTarget(self, action: #selector(walletManageBtnAction), for: .touchUpInside)
        self.view.addSubview(walletManageBtn)
        walletManageBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.left.equalTo(self.view).offset(100)
        }
    }

    @objc func walletManageBtnAction() {
        let dailyCashVC = DailyCashViewController()
        self.navigationController?.pushViewController(dailyCashVC, animated: true)
    }
}
