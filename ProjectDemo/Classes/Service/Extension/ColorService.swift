//
//  ColorService.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

extension UIColor {
    public class var defaultMainHex:String {
        return "#24C793"
    }
    public class var defaultMainColor:UIColor {
        return UIColor.colorWith(hex: UIColor.defaultMainHex)
    }
    
    public class var defaultBlackHex:String {
        return "#333333"
    }
    public class var defaultBlockColor:UIColor {
        return UIColor.colorWith(hex: UIColor.defaultBlackHex)
    }
    
    public class var defaultGraykHex:String {
        return "#999999"
    }
    public class var defaultGrayColor:UIColor {
        return UIColor.colorWith(hex: UIColor.defaultGraykHex)
    }
    
    
    
}
