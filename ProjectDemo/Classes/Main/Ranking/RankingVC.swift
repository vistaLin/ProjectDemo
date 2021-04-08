//
//  TankingVC.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

class RankingVC: HomeBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightBarItem(imageName: "rule_top_bar")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LoginViewModel.shared.selectAdCode != LoginViewModel.shared.rankingSelectAdCode {
            LoginViewModel.shared.rankingSelectAdCode = LoginViewModel.shared.selectAdCode
            viewModel.iOSCallSetSelectAdCode(LoginViewModel.shared.rankingSelectAdCode)
            webContentView?.wkWebView?.reload() // H5要求在刷新一次页面 不然接收不到方法
            
        }
    }
}

extension RankingVC {
    override func rightBarClicked() {
        let vc = RankRuleViewController.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}


