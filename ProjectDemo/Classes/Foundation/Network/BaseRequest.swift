//
//  BaseRequest.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/9.
//

import Foundation

class BaseRequest:NSObject {
    var url:String?
    var parameterDic:Dictionary<String, Any>?
    var isLoading = false
    var loadingText:String?
    var isCache = false
    func getCacheKey() -> String {
        var path = url
        if parameterDic != nil {
            for (key, value) in parameterDic! {
                path! += "&\(key)=\(value)&"
            }
        }
        return path?.MD5Encrypt() ?? ""
    }
}
