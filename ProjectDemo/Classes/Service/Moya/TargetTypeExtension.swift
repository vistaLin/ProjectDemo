//
//  TargetTypeExtension.swift
//  ProjectDemo
//
//  Created by Lennon on 2021/4/6.
//

import Foundation
import Moya
import RxSwift
import HandyJSON

//登录token-用于moya插件
struct AuthPlugin: PluginType {
    
    /**
     每次网络请求带上token-用于moya
     */
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
//        request.addValue(String.appVersion(), forHTTPHeaderField: "app_version")
        request.addValue("application/json;", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("ios", forHTTPHeaderField: "ua_device")
//        request.setValue(UIDevice.current.name, forHTTPHeaderField: "ua_model")
//        request.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: "ua_osVersion")
//        if let token = try? LoginViewModel.shareInstance.loginStatusSubject.value().token  {
//            request.addValue(token, forHTTPHeaderField: "token")
//        }
        return request
    }
}

func moya_getTask(WithParames params: [String: Any]?,isPost: Bool = false) -> Task {
    
    var requestParams = [String: Any]()
    params?.forEach({ (key,value) in
        requestParams[key] = value
    })
    if isPost {
        return  .requestParameters(parameters:requestParams, encoding:  JSONEncoding.default)
    } else {
        return  .requestParameters(parameters:requestParams, encoding: JSONEncoding.default)
    }
}

extension TargetType {
    /**
     获得网络请求的observable
     - parameter 返回对象的类型
     - parameter storeLocal 是否本地缓存
     - parameter addStoreLocalParam 本地混存的key是否加入请求参数
     */
    func getObservable<T>(objType: T.Type,storeLocal: Bool = false,addStoreLocalParam: Bool = false) -> Observable<BaseRxResult<T>> where T: HandyJSON {
        let providerTool = MoyaProviderTool<Self,T>()
        let observable = providerTool.request_rx(self,storeLocal: storeLocal,addStoreLocalParam: addStoreLocalParam)
        //catchError 把可能存在的网络请求错误onNext返回
        return observable.catchErrorJustReturn(BaseRxResult.error)
    }
    
    public var baseURL: URL {
        return URL.init(string: Config.BaseURL)!
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    public var validate: Bool {
        return false
    }
    
    public var sampleData: Data {
        return Data()
    }
}
