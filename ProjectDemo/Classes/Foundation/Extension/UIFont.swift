//
//  UIFont.swift
//  XSCommon
//
//  Created by 漆珏成 on 2019/5/6.
//  Copyright © 2019年 grdoc. All rights reserved.
//

import UIKit

extension UIFont {
  public static func medium(_ fontSize: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Medium", size: fontSize);
  }
  
  public static func regular(_ fontSize: CGFloat) -> UIFont! {
    return UIFont(name: "PingFangSC-Regular", size: fontSize);
  }
  
  public static func semibold(_ fontSize: CGFloat = 14) -> UIFont {
    return UIFont(name: "PingFangSC-Semibold", size: fontSize)!;
  }
  
  public static func light(_ fontSize: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Light", size: fontSize);
  }
}
