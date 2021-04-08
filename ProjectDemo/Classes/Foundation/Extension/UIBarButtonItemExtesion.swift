//
//  UIBarButtonItemExtesion.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/11.
//

import UIKit

extension UIBarButtonItem {
    class func setupItem(imageName:String?, target:Any?, action:Selector, isLeft:Bool = true) -> UIBarButtonItem {
        let button = UIButton.init()
        // 27
        button.setImage(UIImage.init(named: imageName ?? ""), for: .normal)
//        button.backgroundColor = UIColor.red
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            if isLeft  == true {
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0);
            } else {
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right:  -20);
            }
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
}
