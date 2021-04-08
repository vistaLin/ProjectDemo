//
//  LoginViewModel.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/11.
//

import UIKit

public class LoginViewModel {
    static let shared:LoginViewModel = LoginViewModel()
    var loginModel:LoginModel?
    var selectAdCode:String?  // 选中的selectAdCode
    var rankingSelectAdCode:String? // ranking页面传递的acode 如果和selectAdCode不一致那么就要调用js的方法刷新页面
    var selectLevel:Int? //选中区域的等级 {0:country, 1:province, 2:city, 3:area, 9:orgbg, 10:unknown}  请求的等级
    var areaName:String? //正常是读取缓存  如果选中了那么久改变名称
    private init() {
        if let json = CacheHelper.readData(key: JsonLocalKey.LoginModelKey) {
            configData(json: json as? String)
        }
    }
    
    func isLogin() -> Bool {
        if LoginViewModel.shared.loginModel != nil {
            return true
        }
        return false
    }
    func loginSuccess(json:String?) {
        configData(json: json)
        CacheHelper.saveData(value: json, key: JsonLocalKey.LoginModelKey)
    }
    func exitLogin() {
        loginModel = nil
        selectAdCode = nil
        rankingSelectAdCode = nil
        selectLevel = nil
        areaName = nil
        CacheHelper.removeData(key:JsonLocalKey.LoginModelKey)
        CacheHelper.removeData(key: JsonLocalKey.UserInfoModelKey)
        CacheLoginAreaModel.removeAreaData()
        
        let vc:UIViewController? = UIViewController.getCurrentVC()
        if vc != nil && vc!.isKind(of: LoginVC.self) {
            
        } else {
            vc?.view.removeFromSuperview()
            vc?.removeFromParent()
            LoginViewModel.pushLoginVC()
        }
    }
    
    func exitLoginVC() {
        
    }
}

extension LoginViewModel {
    private func configData(json:String?) {
        loginModel = self.getLoginModelFrom(json)
        //要求配置选中的 且可能改变
        selectAdCode = loginModel?.adcode
        selectLevel = loginModel?.level
        areaName = CacheLoginAreaModel.getAreaName()
    }
    
    private func getLoginModelFrom(_ json:Any?) -> LoginModel? {
        return CodableUtils.fromJson(json as? String, toClass: LoginModel.self)
    }
}

extension LoginViewModel {
    class func pushLoginVC() {
        let navi = CustomNavigationVC.init(rootViewController: LoginVC.init())
        UIApplication.shared.keyWindow?.rootViewController = navi
    }
   
}
