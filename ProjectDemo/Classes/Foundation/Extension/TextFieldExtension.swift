//
//  TextFieldExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

extension UITextField {
    //添加初始化方法
    convenience init(fontSize:CGFloat = 13, colorHex:String="#999999" , text:String="") {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = UIColor.colorWith(hex: colorHex)
        self.text = text
    }
}
