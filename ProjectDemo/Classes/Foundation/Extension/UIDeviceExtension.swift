//
//  UIDeviceExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/15.
//

import UIKit

extension UIDevice {

    
    class public func isBang() -> Bool {
   
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        if #available(iOS 11.0, *) {
            if window?.safeAreaInsets.bottom == 0 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
        
    
    }
}
