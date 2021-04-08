//
//  LabelExtension.swift
//  f3hyj
//
//  Created by 张永 on 2016/11/24.
//  Copyright © 2016年 hyju. All rights reserved.
//

import UIKit

extension UILabel {

    //添加初始化方法
    convenience init(fontSize:CGFloat = 13, colorHex:String="#999999" , text:String="") {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = UIColor.colorWith(hex: colorHex)
        self.text = text
    }
    
    
    
    /**
     设置Label一行间距
     - Parameter text: 显示文字
     - Parameter lineSpacing: 间距
     */
    func setText(text: String,lineSpacing: CGFloat) {
        self.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, text.count))

        
        self.attributedText = attributedString
    }
    /**
     设置Label行间间距
     - Parameter text: 显示文字
     - Parameter ratio: 倍率
     */
    func setTextWordSpace(text: String,ratio: Float) {
        let valueNumber = NSNumber.init(value: ratio)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: valueNumber, range:NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
    
    /// 根据文字获取label的高度
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
