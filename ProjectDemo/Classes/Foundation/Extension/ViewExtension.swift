//
//  IMViewExtension.swift
//  jiajia-fun
//
//  Created by Lennon on 2021/1/14.
//

import UIKit

typealias TapGestureAction = (_ view:UIView) -> Void
struct ViewTapKey {
    // ClosureKey
   static var closureKey = 0
   static var selectedKey = 1
}

extension UIView {

    
    ///点击闭包,动态保存
    var tapGestureAction : TapGestureAction? {
        set(newTapGestureAction) {
            let objectWrapper = ObjectWrapper(tapGestureAction: newTapGestureAction!)
            objc_setAssociatedObject(self, &ViewTapKey.closureKey, objectWrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }  get {
            let objectWrapper = objc_getAssociatedObject(self, &ViewTapKey.closureKey) as? ObjectWrapper
            return objectWrapper?.tapGestureAction
        }
    }
    /**
     设置点击事件
     - Parameter closture: 点击回调
     */
    func setTapGesture(_ closture:@escaping TapGestureAction) {
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.viewDidTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        self.tapGestureAction = closture
    }
    
    @objc func viewDidTap() {
    
        self.tapGestureAction?(self)
    }
    
    ///根据类名返回xib构造的view
    class func defaultXibView() -> Self? {
        
        
        let fullClassName : NSString = NSStringFromClass(self) as NSString
        let views = UINib(nibName: fullClassName.className ?? "" , bundle: nil).instantiate(withOwner: nil, options: nil)
        for  view in views {
            if (view as AnyObject).isMember(of: self) {
                return view as? Self
            }
        }
        return nil
    }
}

extension UIView {
    
    
    //    默认为5 一般app的圆角都是5 并且都是.allConers的模式  延迟0.01 否则无布局的时候剪切会有问题
        func addConner(value: CGFloat = 5) {
            self.addConner(radius: value)
        }

    
    func addConner(radius:CGFloat = 5, borderColorHex:String = "#999999", borderWidth:CGFloat = 0, byRoundingCorners: UIRectCorner = .allCorners) {
      // 使用CAShapeLayer内存消耗少,渲染速度快 但是也会发生离屏渲染
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
        // 1.绘制图形圆角
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        // 2.如果有边框 边框
        if borderWidth == 0 {
          return
        }
        let borderLayer = CAShapeLayer.init()
        //设置边框的路径
        borderLayer.path = maskPath.cgPath;
        //边框的宽度
        borderLayer.lineWidth = borderWidth;
        borderLayer.fillColor = UIColor.clear.cgColor;
        //边框的颜色
        borderLayer.strokeColor = UIColor.colorWith(hex: borderColorHex).cgColor;
        //这个需要注意的
        borderLayer.frame = self.bounds;
        self.layer.addSublayer(borderLayer)
      }
      
    }
    
    
}

///避免x,y这种类型和三方库重名， 加入命名空间
extension  UIView {
    var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.origin.x = newValue
            self.frame = tempFrame
        }
    }
    
    var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.origin.y = newValue
            self.frame = tempFrame
        }
    }
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.size.width = newValue
            self.frame = tempFrame
        }
    }
    
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            var tempCenter : CGPoint = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }
    }
    var centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            var tempCenter : CGPoint = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
    }
    var size : CGSize {
        get {
            return self.frame.size
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.size = newValue
            self.frame = tempFrame
        }
    }
    
    var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.origin.x = newValue - self.frame.size.width
            self.frame = tempFrame
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var tempFrame : CGRect = self.frame
            tempFrame.origin.y = newValue - self.frame.size.height
            self.frame = tempFrame
        }
    }
    
//    func setHeight(_ h:CGFloat) {
//        self.frame = CGRect.init(x: self.x, y: self.im.y, width: self.im.width, height: h)
//    }
//    
//    func setY(_ Y:CGFloat) {
//        self.frame = CGRect.init(x: self.x, y: Y, width: self.width, height: self.height)
//    }
}

// MARK:设置尺寸

//extension IMKitNameSpace where Base: UIView {
//    func setHeight(_ height:CGFloat) {
//        self.frame = CGRect.init(x: self.x, y: self.im.y, width: self.im.width, height: <#T##CGFloat#>)
//    }
//}

// MARK: 添加重用标识符
protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UIView: ReusableView {
}


