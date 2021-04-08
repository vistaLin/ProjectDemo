//
//  SizeHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

class SizeHelper {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    // Status bar iPhoneX高44 而一般的高度一般的手机高度为20
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    // 写死 20 + 44 或者 44 + 44
    static let navigationBarHeight = (statusBarHeight + 44)
    

//   // 是否是全面屏 iPhoneX / iPhoneXS 和iPhoneXR / iPhoneXSMax 不准确 要修正
//    static let isFullScreenPhone = (screenWidth == 375 && screenHeight == 812 ? true : false) || (screenWidth == 414 && screenHeight == 896 ? true : false)
//    // 全面屏底部高度为34  非全面为0
    static let homeIndicatorHeight:CGFloat = UIDevice.isBang() ? 34 : 0
    static let tabbarHeight:CGFloat = homeIndicatorHeight + 49
}

// Method
extension SizeHelper {
    // 宽度根据比例设置
    static func autoWidth(_ size : CGFloat) -> CGFloat {
        return (SizeHelper.screenWidth / 375) * size
    }
    static func autoHeight(_ size : CGFloat) -> CGFloat {
        return (SizeHelper.screenWidth / 812) * size
    }
}
