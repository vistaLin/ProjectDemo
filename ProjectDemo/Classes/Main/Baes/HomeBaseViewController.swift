//
//  HomeBaseViewController.swift
//  HomeDoctorManager
//
//  Created by Lennon on 2021/3/26.
//

import UIKit

class HomeBaseViewController: YDYWebViewController {
    // mineVIewMode
    lazy  var mineViewModel = {
        return MineViewModel.init()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftBarItem(imageName: "userInfo_top_bar")
    }
    @objc override func leftBarClicked()  {
        self.mineViewModel.show()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 因为可能改变 所以每次展示的时候都重新复制
        self.navigationItem.title = LoginViewModel.shared.areaName
    }
}
