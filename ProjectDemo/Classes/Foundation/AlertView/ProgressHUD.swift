//
//  ProgressHUD.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit
import MBProgressHUD

class ProgressHUD {
    static let defaultTimeInterval = 1.2
    class func showMessage(_ message:String?)  {
        guard let message = message else {
            return
        }
        // 异步线程会崩溃 自动到主线程刷新UI
        DispatchQueue.main.async {
            let hud = ProgressHUD.createHUD(view: nil, title: message, hubModel: .text)
            hud?.hide(animated: true, afterDelay: defaultTimeInterval)
        }
    }
    
    class func showIndicatorHUD(view: UIView?, title:String? ) {
        DispatchQueue.main.async {
            let hud = ProgressHUD.createHUD(view: view, title: title, hubModel: .indeterminate)
            hud?.bezelView.backgroundColor = .white
        }
    }
    
    class func hideHUD(title:String?, view:UIView?)  {
        if view == nil &&  UIApplication.shared.windows.first == nil{
            debugPrint("隐藏hud异常")
            return
        }
        MBProgressHUD.hide(for: view ?? UIApplication.shared.windows.first!, animated: true)
        if title != nil {
            self.showMessage(title)
        }
       
        
    }
    
    private class func createHUD(view:UIView?, title:String?, hubModel:MBProgressHUDMode) -> MBProgressHUD? {
        var contentView = view
        if contentView == nil {
            contentView = UIApplication.shared.windows.first
        }
        if contentView == nil {
            return nil
        }
        let hud = MBProgressHUD.showAdded(to: contentView! , animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.mode = hubModel
        if title != nil {
            hud.detailsLabel.text = title
            hud.detailsLabel.font = UIFont.systemFont(ofSize: 14)
            hud.detailsLabel.textColor = .white
        }
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor.colorWith(hex: "#000000")
        hud.hide(animated: true, afterDelay: ProgressHUD.defaultTimeInterval)
        return hud
    }
    
  
}
