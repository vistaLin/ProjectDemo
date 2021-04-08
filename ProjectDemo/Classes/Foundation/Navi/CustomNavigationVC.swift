//
//  CustomNavigationVC.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

class CustomNavigationVC: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.colorWith(hex: "#24C793")
        // 去除分割线
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        // 避免自定义leftbar导致手势失效
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }

        // 必须设置为false 否则barTintcolor颜色不对
        navigationBar.isTranslucent = false
    }
    // 重新此方法 为了让外部vc去设置statusbar的style
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    // !!!存在和scrollView手势冲突问题 可能导致卡死
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            let vc = self.viewControllers[0]
            if self.viewControllers.count < 2 || self.visibleViewController == vc {
                return false
            }
        }
        return true
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
