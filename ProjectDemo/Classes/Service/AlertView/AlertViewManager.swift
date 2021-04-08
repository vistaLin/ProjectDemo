//
//  AlertViewManager.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/15.
//

import UIKit

class AlertViewManager {

    var subView:UIView?
    var grayBGView:AlertBackgroundView?
    var initFrame:CGRect? // 为了成为值引用 避免被释放
    var isShowAlertView = false
    init() {
    }
    
    func showAlertView(view:UIView?, changeFrame:CGRect) {
        if grayBGView != nil {
            return
        }
        isShowAlertView = true
        
        subView = view
        initFrame = view?.frame
        
        grayBGView = AlertBackgroundView.init()
        let window = UIApplication.shared.keyWindow
        window?.addSubview(grayBGView!)
        grayBGView?.frame = UIScreen.main.bounds
        grayBGView?.getDismissBlock {
            self.dismiss(changeFrame: self.initFrame)
        }

        
        window?.addSubview(subView!)
        UIView.animate(withDuration: 0.3) {
            self.grayBGView?.alpha = 1
            self.subView?.frame = changeFrame
        }
    }
    
    func dismiss(changeFrame:CGRect?){
        if changeFrame != nil {
            initFrame = changeFrame
        }
        UIView.animate(withDuration: 0.3) {
            self.subView?.frame = self.initFrame ?? CGRect.zero
            self.grayBGView?.alpha = 0
        } completion: { (finish) in
            if finish == true {
                self.isShowAlertView = false
                self.subView?.removeFromSuperview()
                self.subView = nil
                self.grayBGView?.removeFromSuperview()
                self.grayBGView = nil
                
            }
        }
    }
}
