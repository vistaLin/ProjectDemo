//
//  BaseRxResult.swift
//  jiajia-fun
//
//  Created by 张永 on 2020/12/31.
//

import Foundation
import HandyJSON
import RxSwift
import Alamofire



///对网络结果的封装
enum BaseRxResult<T: HandyJSON> {
    
    case success(String?)
    case fail(String?) //业务错误
    case error  //服务器内部错误
    case loading //等待请求
    case noNetwork //没网
    case over // 结束
     
//    var data: T? {
//        if case let .success(str) = self {
//        let data = JSONDeserializer<ObjectHandyResult<T>>.deserializeFrom(json: str)
//            return data?.result
//        } else {
//            return nil
//        }
//    }
//    
//    var datas: [T]? {
//        if case let .success(str) = self {
//        let data = JSONDeserializer<ObjectHandyResults<T>>.deserializeFrom(json: str)
//            return data?.result
//        } else {
//            return nil
//        }
//    }
    
    /// 包装在Result里面的数组
//    var wrapDatas:[T]? {
//        if case let .success(str) = self {
//        let data = JSONDeserializer<ObjectHandyResults<T>>.deserializeFrom(json: str)
//            return data?.result.data
//        } else {
//            return nil
//        }
//    }
    
//    var failData: ErrorModel? {
//        if case let .fail(str) = self {
//            let model = JSONDeserializer<ErrorModel>.deserializeFrom(json: str)
//            return model
//        }
//        return nil
//    }
//
    var noWrapData: T? {
        if case let .success(str) = self {
        let data = JSONDeserializer<T>.deserializeFrom(json: str)
            return data 
        } else {
            return nil
        }
    }
    
    var successString: String? {
        if case let .success(str) = self {
          return str
        } else {
          return nil
        }
    }
    
    func isSuccess() -> Bool {
        if case  .success(_) = self {
            return true
        }
        return false
    }
    
    
    
    @discardableResult
    func executeShow(exclude: BaseRxResult? = nil) -> BaseRxResult {
        
        if exclude == self {
             return self
        }
        
        if case  .over = self {
            return self
        }
        
        if NetworkReachabilityManager.default?.isReachable == false {
       //     JGProgressHUDHelper.shareInstance.showErrorHUDWithMsg(msg: "没网了?")
            return self
        }
        
//        switch self {
//        case .fail(let str):
//            self.executeFail(str: str)
//        case .error:
//          //  JGProgressHUDHelper.shareInstance.showErrorHUDWithMsg(msg: "服务器内部错误")
//        case .loading:
//         //   JGProgressHUDHelper.shareInstance.showJGPHUDLoading()
//        case .success:
//JGProgressHUDHelper.shareInstance.dissmissHUD(animate: false)
            
//        default:
//            break
//        }
        return self
    }
    
    func executeFail(str: String?) {
        guard let str = str else {return}
//        let model = JSONDeserializer<ErrorModel>.deserializeFrom(json: str)
//        switch model?.code ?? -1{
//        case -1:
//            JGProgressHUDHelper.shareInstance.showErrorHUDWithMsg(msg: "服务器内部错误")
//        case 401: //登录过期  防止杀掉应用被别的设备登录/防止美信网络连接丢失的时候被退出登录
////            JGProgressHUDHelper.shareInstance.show()
//            JGProgressHUDHelper.shareInstance.showHUDloadingWithString(string: "你的账号当前已在其他设备登录")
//            LoginViewModel.shareInstance.loginOut()
//        case 5001: //验证吗错误
//            JGProgressHUDHelper.shareInstance.showHUDloadingWithString(string: "验证码错误")
//
//        default:
//            JGProgressHUDHelper.shareInstance.showHUDloadingWithString(string: model?.message ?? "")
//        }
    }
    
}

extension BaseRxResult: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs,rhs) {
        case (success,success):
            return true
        case (fail,fail):
            return true
        case (error,error):
            return true
        case (loading,loading):
            return true
        case (noNetwork,noNetwork):
            return true
        case (over,over):
            return true
        default:
            return false
        }
    }

}

///对自定义操作的结果封装，如上传图片
//enum CommonRxResult {
//    case success(Any?)
//    case fail(String?) //错误
//    case loading(Any?) //等待请求
//    case over // 结束
//    
//    func successData() -> Any? {
//        if case let .success(data) = self {
//            return data
//        } else {
//            return nil
//        }
//    }
//    
//    func executeShow(showLoading: Bool = false ) -> Any {
//        
//        if case  .over = self {
//            return self
//        }
//        
//        switch self {
//        case .fail(let str):
//            JGProgressHUDHelper.shareInstance.showErrorHUDWithMsg(msg: str)
//        case .loading:
//            JGProgressHUDHelper.shareInstance.showJGPHUDLoading()
//        case .success:
//            JGProgressHUDHelper.shareInstance.dissmissHUD()
//        default:
//            break
//        }
//        return self
//    }
//}

