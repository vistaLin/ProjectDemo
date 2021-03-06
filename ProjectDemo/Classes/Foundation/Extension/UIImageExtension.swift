//
//  UIImageExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/19.
//

import UIKit

extension UIImage {

    //将图片缩放成指定尺寸（多余部分自动删除）
     func scaledToNewSize(_ newSize: CGSize) -> UIImage {
         //计算比例
         let aspectWidth  = newSize.width/size.width
         let aspectHeight = newSize.height/size.height
         let aspectRatio = max(aspectWidth, aspectHeight)
          
         //图片绘制区域
         var scaledImageRect = CGRect.zero
         scaledImageRect.size.width  = size.width * aspectRatio
         scaledImageRect.size.height = size.height * aspectRatio
         scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
         scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
          
         //绘制并获取最终图片
         UIGraphicsBeginImageContext(newSize)
         draw(in: scaledImageRect)
         let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
          
         return scaledImage!
     }
}
