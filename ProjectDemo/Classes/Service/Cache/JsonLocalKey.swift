//
//  JsonLocalKey.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/12.
//

import Foundation

// MARK: 不能清除的数据
struct JsonLocalKey {
    static let LoginModelKey = "JsonLocalKey_LoginModelKey"
    static let UserInfoModelKey = "JsonLocalKey_UserInfoModelKey"
    static let isLoadGuidePageKey = "JsonLocakKey_isLoadGuidePageKey"
}

extension JsonLocalKey {
    static let selectAreaModelKey = "JsonLocalKey_selectAreaModelKey"
    static let selectAreaArrayKey = "JsonLocalKey_selectAreaArrayKey"
    // 当前登录的区域模型
    static let currentLoginAreaModel = "JsonLocalKey_currentLoginTopAreaModel"
}
