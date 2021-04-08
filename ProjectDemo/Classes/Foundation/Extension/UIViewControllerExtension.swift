//
//  UIViewControllerExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/12.
//

import UIKit

extension UIViewController {
    // 获取当前视图
    class func getCurrentVC() -> UIViewController? {
      var vc = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
      while (true) {
        if (vc?.isKind(of: UITabBarController.self))! {
          vc = (vc as! UITabBarController).selectedViewController
        }else if (vc?.isKind(of: UINavigationController.self))!{
          vc = (vc as! UINavigationController).visibleViewController
        }else if ((vc?.presentedViewController) != nil){
          vc =  vc?.presentedViewController
        } else {
          break
        }
      }
      return vc!
    }

    func isRootVC() -> Bool {
        if UIApplication.shared.windows[0].rootViewController == self {
            return true
        }
        return false
    }
}
