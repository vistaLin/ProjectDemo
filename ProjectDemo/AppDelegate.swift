//
//  AppDelegate.swift
//  ProjectDemo
//
//  Created by Lennon on 2021/4/6.
//

import UIKit
import IQKeyboardManager
import RealmSwift

// 初始化数据库
let realmOne = try! Realm()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // webView缓存池
        let _ = CustomWebViewPool.shared
        keyboardConfig()
        initRootVC()
//        let router: AppRouting = AppRouter.shared
//        // swiftlint:disable no_hardcoded_strings
//        router.register(path: "InternalMenu", navigator: InternalMenuNavigator())
        
        return true
    }

    // 完成切换到后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        changeAppStatus(isBackground: true)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        changeAppStatus(isBackground: false)
    }

}

// MARK: Private
extension AppDelegate {
    private func initRootVC()  {
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = .white
       
        if GuidePageHelper.isLoadGuidePageVC {
            window?.rootViewController = GuidePageViewController()
        } else {
            if LoginViewModel.shared.isLogin() == true {
                window?.rootViewController = MainTabBarVC()
            } else {
                window?.rootViewController = CustomNavigationVC.init(rootViewController: LoginVC.init())
            }
        }

        window?.makeKeyAndVisible()
    }
    
    private func keyboardConfig() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    // 切换到前后台的时候调用
    private func changeAppStatus(isBackground:Bool) {
        if LoginViewModel.shared.isLogin() == false {
           return
        }
        let request = BaseRequest.init()
        request.url = "AddManagerClientSwitchLog"
        if isBackground == false {
            request.parameterDic = ["doWhat" : "SwitchFront"]
        } else {
            request.parameterDic = ["doWhat" : "SwitchBack"]
        }
        NetworkHelper.postRequest(request: request) { (reponse) in
            
        } failure: { (error) in
            
        }

    }
}

