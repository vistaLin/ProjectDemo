//
//  NSMutableAttributedStringExtension.swift
//  HomeDoctorManager
//
//  Created by Lennon on 2021/3/25.
//

import UIKit

extension NSMutableAttributedString {
  
  // 添加第二段富文本
  public static func attributedSubColor(_ text: String,
                                        _ sub: String,
                                        _ subColor: UIColor = UIColor.defaultMainColor,
                                        _ subFont: UIFont = UIFont.semibold(14)) -> NSAttributedString {
    let attributed = NSMutableAttributedString(string: text)
    let subAttr = NSMutableAttributedString.init(string: sub)
    let subTextRange:NSRange = NSRange.init(location: 0, length: sub.count)
    subAttr.addAttribute(.foregroundColor, value: subColor, range: subTextRange)
    subAttr.addAttribute(.font, value: subFont, range: subTextRange)
    attributed.append(subAttr)
    return attributed
  }
    
    public static func setupLineMargin(text:String?, margin:CGFloat = 8) -> NSAttributedString? {
        guard let text = text else {
            return nil
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = margin
        let attributeStriung:NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributeStriung.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, text.count))
        return attributeStriung
    }
}

