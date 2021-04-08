//
//  ButtonExtension.swift
//  jiajia-fun
//
//  Created by Lennon on 2021/1/14.
//

import UIKit

enum ButtonEdgeInsetStyle:Int {
    case top // image在上，label在下
    case left
    case bottom
    case right
}

extension UIButton {
    convenience init(fontSize:CGFloat=13, colorHex:String = "#333333", text:String="") {
        self.init()
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize )
        self.setTitleColor(UIColor.colorWith(hex: colorHex), for: .normal)
    }
}


typealias BtnAction = (_ button:UIButton)->()

extension UIButton {
    
    
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
    }
    
    @objc dynamic var action: BtnAction? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? BtnAction{
                return action
            }
            return nil
        }
    }

    func touchUpInSideAction(_ action:@escaping BtnAction){
        self.action = action
        self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
    }

    @objc func touchUpInSideBtnAction(_ btn: UIButton) {
         if let action = self.action {
            action(self)
         }
    }
    
}

extension UIButton {
    ///  设置button的titleLabel和imageView的布局样式，及间距
    func layoutEdgeInset(style:ButtonEdgeInsetStyle = .left, margin:CGFloat = 0) {
        
        // 1. 得到imageView和titleLabel的宽、高
        let  imageWith:CGFloat = self.imageView?.image?.size.width ?? 0
        let imageHeight:CGFloat = self.imageView?.image?.size.height ?? 0
        
        let   labelWidth:CGFloat = self.titleLabel?.intrinsicContentSize.width ?? 0
        let   labelHeight:CGFloat = self.titleLabel?.intrinsicContentSize.height ?? 0
        
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var   imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero;
        var   labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero;
        
        // 3. 根据style和margin得到imageEdgeInsets和labelEdgeInsets的值
        switch (style) {
        case .top:
            
            imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight - margin/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith, bottom: -imageHeight , right: 0);

                break;
        case .left:
                // 有空直接拓展这个设置居左右的设置
            if (self.contentHorizontalAlignment == .left) {
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: margin, bottom: 0, right: margin/2.0);
                labelEdgeInsets = UIEdgeInsets.init(top: 0, left: margin/2.0 + margin, bottom: 0, right: -margin/2.0);
                } else {
                    imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -margin/2.0, bottom: 0, right: margin/2.0);
                    labelEdgeInsets = UIEdgeInsets.init(top: 0, left: margin/2.0, bottom: 0, right: -margin/2.0);
            }
                break;
        case .bottom:
            do {
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -labelHeight-margin/2.0, right: -labelWidth);
                labelEdgeInsets = UIEdgeInsets.init(top: -imageHeight-margin/2.0, left: -imageWith, bottom: 0, right: 0);
            }
                break;
        case .right:
            
                imageEdgeInsets = UIEdgeInsets.init(top: 0, left: labelWidth+margin/2.0, bottom: 0, right: -labelWidth-margin/2.0);
                labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith-margin/2.0, bottom: 0, right: imageWith+margin/2.0);
            
                break;
            default:
                break;
        }
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
    /// 固定按钮宽度 图片和文字有距离的时候 为了在button按钮宽度不够的时候的显示
    func fiexdButtonWidthEdgeInset(style:ButtonEdgeInsetStyle = .left, margin:CGFloat = 0) {
        
    }
    
    /**
     让button的图片在文字上面，并且都居中
     - parameter imageAboveText:  是否居中且垂直
     - parameter spacing: 距离
     */
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            // https://stackoverflow.com/questions/2451223/#7199529
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font
            else { return }
            
            let titleSize = text.size(withAttributes: [.font: font])
            
            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)
            
            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)
            
            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
}

