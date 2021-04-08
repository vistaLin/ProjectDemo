//
//  NetManager.swift
//  OK-Dai
//
//  Created by 张永 on 16/9/22.
//  Copyright © 2016年 zy. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import RxSwift
import Alamofire


class CommonNetModel: HandyJSON {
    var code: Int?
    var message: String?
    required init() {}

}

class MoyaProviderTool<T: TargetType,R: HandyJSON> {
    
    let moyaProvider: MoyaProvider<T>
    
    init() {
        ///配置网络请求，如超时时间
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let session = Session(configuration: configuration, startRequestsImmediately: false)
        let moyaProvider = MoyaProvider<T>(session: session,plugins: [AuthPlugin()])
        self.moyaProvider = moyaProvider
    }
    
//    @discardableResult
    /**
     网络请求的封装
     - parameter target: 请求实体
     - parameter storeLocal: 是否本地缓存
     - parameter addStoreLocalParam: 本地缓存是否根据参数区分
     */
    func request_rx(_ target: T,storeLocal: Bool = false,addStoreLocalParam: Bool = false) -> Observable<BaseRxResult<R>>{
        
        //网络请求的observable
        let observable: Observable<BaseRxResult> = self.moyaProvider.rx.request(target).asObservable().map({ response -> BaseRxResult<R> in
            if response.statusCode != 200 {
                return BaseRxResult.error
            }
            let str = String(data: response.data, encoding: String.Encoding.utf8) ?? ""
            print("接口: " + target.path + "----------->")
            
            print(str)
            let model = JSONDeserializer<CommonNetModel>.deserializeFrom(json: str)
            if model?.code == 200 {
                return BaseRxResult.success(str)
            } else {
                return BaseRxResult.fail(str)
            }
            
        }).do { (result) in
            ///如果需要本地缓存，则存在本地
            if storeLocal {
                if case let .success(str) = result {
                    if let str = str {
                        KeyValueDao.saveCacheData(key: self.getStoreKey(withTarget: target,addStoreLocalParam: addStoreLocalParam), value: str)
                    }
                }
            }
        }
        if storeLocal {
            //本地缓存Obverable

            let localObverable =  Observable<BaseRxResult<R>>.create { (observer) -> Disposable in
                
                if let jsonString = KeyValueDao.getCacheData(key: self.getStoreKey(withTarget: target,addStoreLocalParam: addStoreLocalParam)) {
                    observer.onNext(BaseRxResult.success(jsonString))
                } else {
                    observer.onCompleted()

                }
                return Disposables.create()
            }
            //没网返回本地结果和无网络结果
            if NetworkReachabilityManager.default?.isReachable == false {
                let noNetwork = Observable.just(BaseRxResult<R>.noNetwork)
                return Observable.of(noNetwork,localObverable).merge()
            } else {
                //有网返回本地结果和网络结果
                return Observable.of(localObverable,observable).merge()
            }
            
        } else {
            //没有本地缓存直接返回无网
            if NetworkReachabilityManager.default?.isReachable == false {
                return Observable.just(BaseRxResult<R>.noNetwork)
            } else {
                return observable
            }
        }
    }
    
    /**
     获取本地储存的key
     - parameter target: 网络请求实体
     - parameter addStoreLocalParam: 是否添加本地参数
     */
    func getStoreKey(withTarget target: T,addStoreLocalParam: Bool) -> String{
        var path = target.path + "_"
        
        if addStoreLocalParam {
            if  case let .requestParameters( parameters,  _) = target.task{
                    
                    for (key,value) in parameters {
                        path += "&\(key)=\(value)&"
                    }
                
            }
        }
        
        let method = target.method
        switch method {
        case .post:
            path += (path + "post")
        case .put:
            path += (path + "put")
        case .delete:
            path += (path + "delete")
        case .get:
            path += (path + "get")
        default:
            break
        }
        //直接md5，撞库率太低，可以忽略不计
        return path.MD5Encrypt()
    }
}







