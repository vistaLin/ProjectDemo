//
//  MineViewModel.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/11.
//

import UIKit

class MineViewModel {
    var grayBGView:UIView?
    var mineView:MineView?
    let mineViewWidth = SizeHelper.autoWidth(296)
    lazy var alertViewManager:AlertViewManager = {
        return AlertViewManager.init()
    }()
    init() {
        
    }
}

extension MineViewModel {
    private func fetchData() {
        refreshUserInfo(response: CacheHelper.readData(key: JsonLocalKey.UserInfoModelKey) as? String)
        let request:BaseRequest = BaseRequest.init()
        request.url = "GetAccountOrgInfo"
        request.parameterDic = ["adcodes":[LoginViewModel.shared.loginModel?.adcode ?? ""]]
        
        NetworkHelper.postRequest(request: request) {[weak self] (response) in
            self?.refreshUserInfo(response: response)
            CacheHelper.saveData(value: response, key: JsonLocalKey.UserInfoModelKey)
        } failure: { _ in
            
        }
    }
    private func refreshUserInfo(response:String?) {
        let dic = JsonHelper.dicFromJsonString(response)
        let items:Array = dic?["items"] as? [Dictionary<String, Any>?] ?? []
        if items.count > 0 {
            if items[0]?["name"] != nil {
                if (mineView != nil) {
                    mineView?.name = items[0]?["name"]  as? String ?? ""
                }
            }
        }
    }
}

extension MineViewModel {
    private func isShwoMineFrame(_ isShow:Bool) -> CGRect {
        if isShow == true {
            return CGRect.init(x: 0, y: 0, width: self.mineViewWidth, height: SizeHelper.screenHeight)
        } else {
            return CGRect.init(x: -mineViewWidth, y: 0, width: mineViewWidth, height: SizeHelper.screenHeight)
        }
    }
}

extension MineViewModel {
    func show() {
        mineView = MineView.defaultXibView()
//        mineView?.exitLoginButton.touchUpInSideAction({ (button) in
//            self.alertViewManager.dismiss(changeFrame: nil)
//            LoginViewModel.shared.exitLogin()
//            ProgressHUD.showMessage("退出成功，进入登录页面。")
//        })
        mineView?.frame = isShwoMineFrame(false)
        alertViewManager.showAlertView(view: mineView, changeFrame: self.isShwoMineFrame(true))
        fetchData()
    }
}
