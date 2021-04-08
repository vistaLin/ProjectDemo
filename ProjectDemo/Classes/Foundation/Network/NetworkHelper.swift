//
//  NetworkHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit
import Alamofire
import RxSwift

final class NetworkHelper:NSObject {

    public typealias NetworkSuccess = (_ json:String?) -> Void
    public typealias NetworkFailure = (_ error:Error) -> Void
    
//    private var session:Session?
//    static let shared = NetworkHelper()
//    override init() {
//        super.init()
//
//    }
    
//    class func postRequest(request:BaseRequest) -> Observable<String> {
//
//        guard let urlStr = request.url else {
//            return
//        }
//        if request.isCache {
//            if let json = CacheHelper.readData(key: request.getCacheKey()) {
//                success(json as? String)
//            }
//        }
//        //无网的时候提示用户
//        if NetworkReachabilityManager.default?.isReachable == false {
//            ProgressHUD.showMessage("网络连接失败,请检查您的网络设置")
//            return
//        }
//        let url = Config.BaseURL + urlStr
//        if LoginViewModel.shared.loginModel?.token != nil {
//            if request.parameterDic == nil {
//                request.parameterDic = ["token" : LoginViewModel.shared.loginModel?.token ?? ""]
//            } else {
//                request.parameterDic?.updateValue(LoginViewModel.shared.loginModel?.token ?? "", forKey: "token")
//            }
//        }
//
//        debugPrint("url ===", url, "parameterDic ===", request.parameterDic ?? [])
//        if request.isLoading {
//            ProgressHUD.showIndicatorHUD(view: nil, title: nil)
//        }
//
//        AF.request(url, method: .post, parameters: request.parameterDic, encoding: JSONEncoding.default
//         ).responseString { (response) in
//            if request.isLoading {
//                ProgressHUD.hideHUD(title: nil, view: nil)
//            }
//            switch response.result {
//            case .success(let json):
//                let dic = JsonHelper.dicFromJsonString(json)
//                if dic?["code"] != nil {
//                    let code:Int = dic?["code"] as? Int ?? 0
//                    if code == 200 {
//                        success(json)
//                        if request.isCache {
//                            CacheHelper.saveData(value: json, key: request.getCacheKey())
//                        }
//                    } else if code == 401  {
//                        LoginViewModel.shared.exitLogin()
//                    }
//                } else {
//
//                }
//
//                debugPrint(json)
//                break
//            case .failure(let error):
//                failure(error)
//                debugPrint("error:\(error)")
//                break
//            }
//        }
//    }
    
    
    class func postRequest(request:BaseRequest, success:@escaping NetworkSuccess, failure:@escaping NetworkFailure) {
        
        guard let urlStr = request.url else {
            return
        }
        if request.isCache {
            if let json = CacheHelper.readData(key: request.getCacheKey()) {
                success(json as? String)
            }
        }
        //无网的时候提示用户
        if NetworkReachabilityManager.default?.isReachable == false {
            ProgressHUD.showMessage("网络连接失败,请检查您的网络设置")
            return
        }
        let url = Config.BaseURL + urlStr
        if LoginViewModel.shared.loginModel?.token != nil {
            if request.parameterDic == nil {
                request.parameterDic = ["token" : LoginViewModel.shared.loginModel?.token ?? ""]
            } else {
                request.parameterDic?.updateValue(LoginViewModel.shared.loginModel?.token ?? "", forKey: "token")
            }
        }
  
        debugPrint("url ===", url, "parameterDic ===", request.parameterDic ?? [])
        if request.isLoading {
            ProgressHUD.showIndicatorHUD(view: nil, title: nil)
        }
        
        AF.request(url, method: .post, parameters: request.parameterDic, encoding: JSONEncoding.default
         ).responseString { (response) in
            if request.isLoading {
                ProgressHUD.hideHUD(title: nil, view: nil)
            }
            switch response.result {
            case .success(let json):
                let dic = JsonHelper.dicFromJsonString(json)
                if dic?["code"] != nil {
                    let code:Int = dic?["code"] as? Int ?? 0
                    if code == 200 {
                        success(json)
                        if request.isCache {
                            CacheHelper.saveData(value: json, key: request.getCacheKey())
                        }
                    } else if code == 401  {
                        LoginViewModel.shared.exitLogin()
                    }
                } else {
                   
                }
               
                debugPrint(json)
                break
            case .failure(let error):
                failure(error)
                debugPrint("error:\(error)")
                break
            }
        }
    }
}
