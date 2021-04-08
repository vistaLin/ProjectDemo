//
//  OpenUrlHelper.swift
//  Beauty
//
//  Created by 张永 on 16/4/21.
//  Copyright © 2016年 zy. All rights reserved.
//

import UIKit

class OpenUrlHelper {

    class func openTelphoneWithNumber(number: String? = "00000000",controller: UIViewController) {

        guard let phoneNumber = number , phoneNumber.count > 0 else {
            return
        }
        
//        UIAlertController.showInController(controller, prefrredStyle: .actionSheet, title: nil, message: nil, cancelString: "取消", otherStrings: ["拨打","复制"], animation: true) { (index) in
//            if index == 1 {
                let phoneStr = "tel://" + phoneNumber
                if let phoneUrl = URL(string: phoneStr) {
                    if UIApplication.shared.canOpenURL(phoneUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(phoneUrl,  completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(phoneUrl)
                        }
                    } else {
                    }
                }
//            } else if index == 2 {
//                let past = UIPasteboard.general
//                past.string = number
//                JGProgressHUDHelper.shareInstance.showSuccessHUDWithMsg(msg: "复制成功")
//            }
//        }
    }
    
//    class func openHttpUrl(_ urlString: String?,showHeader: Bool = true) {
   
//
//        guard let urlString = urlString else {
//            return
//        }
//        let showHeaderString = showHeader ? "1":"0"
//        let url = "yours://webview?show_header=" + showHeaderString + "&url=" + urlString
//    }
    
    
}
