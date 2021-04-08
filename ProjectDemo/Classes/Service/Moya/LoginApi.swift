//
//  LoginApi.swift
//  ProjectDemo
//
//  Created by Lennon on 2021/4/6.
//

import Foundation
import Moya

public enum LoginApi {
    case login(String,String)
}

extension LoginApi:TargetType {
    public var path: String {
        switch self {
        case .login:
            return "ManageLogin"
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let name, let password):
            return moya_getTask(WithParames: ["account":name, "password":password.MD5Encrypt()], isPost: true)
       }
    }
}
