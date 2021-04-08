//
//  UIAlertControllerExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/19.
//

import UIKit

extension UIAlertController {
    typealias CommonClosture = (_ result: Any?) -> Void
    typealias CommonObjClosture = (_ result: AnyObject?) -> Void
    typealias CommonClostureNoParamater = () -> Void
    typealias CommonIntClosure = (_ code: Int) -> Void
    typealias CommonSuccessClosure = (_ success: Bool) -> Void
    typealias CommonStringClosure = (_ string: String) -> Void
    
    /**
     指定controller显示系统弹窗
     - Parameter controller: 所在controller
     - Parameter prefrredStyle: 样式
     - Parameter title: 标题
     - Parameter message: 内容
     - Parameter cancelString: 取消文字
     - Parameter otherStrings: 其他按钮文字
     - Parameter animation: 是否有动画
     - Parameter clickAction: 点击闭包 返回一个index 0表示点击取消
     */
    class func showInController(_ controller: UIViewController,prefrredStyle: UIAlertController.Style,title: String?,message: String?,cancelString: String,otherStrings:[String]?,animation: Bool,clickAction: CommonIntClosure?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: prefrredStyle)
        let cancelAction = UIAlertAction(title: cancelString, style: UIAlertAction.Style.cancel) { (action: UIAlertAction) -> Void in
            clickAction?(0)
        }
        alertController.addAction(cancelAction)
        if let otherStrings = otherStrings {
        for (index,string) in otherStrings.enumerated() {
            let action = UIAlertAction(title: string, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
                clickAction?(index + 1)
            })
            alertController.addAction(action)
        }
        }
        controller.present(alertController, animated: true, completion: nil)
    }
    
    /**
     在controller中显示一个带输入框的系统弹框
     - Parameter controller: 所在controller
     - Parameter prefrredStyle: 样式
     - Parameter title: 标题
     - Parameter message: 内容
     - Parameter cancelString: 取消文字
     - Parameter otherStrings: 其他按钮文字
     - Parameter animation: 是否有动画
     - Parameter clickAction: 点击闭包 返回一个string
     */
    class func showTextFieldInController(_ controller: UIViewController,prefrredStyle: UIAlertController.Style,title: String?,message: String?,cancelString: String,otherStrings:[String]?,animation: Bool,clickAction: CommonClosture?) {


        let alertController = UIAlertController(title: title, message: message, preferredStyle: prefrredStyle)
        let cancelAction = UIAlertAction(title: cancelString, style: UIAlertAction.Style.cancel) { (action: UIAlertAction) -> Void in
            clickAction?(nil)
        }
        alertController.addAction(cancelAction)
        alertController.addTextField { (textField) in
            textField.placeholder = "please input"
        }
        if let otherStrings = otherStrings {
            for (_,string) in otherStrings.enumerated() {
                let action = UIAlertAction(title: string, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
                    if let string = alertController.textFields?[0].text {
                    clickAction?(string as AnyObject?)
                    }
                })
                alertController.addAction(action)
            }
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}
