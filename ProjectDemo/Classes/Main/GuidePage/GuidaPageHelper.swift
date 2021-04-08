//
//  GuidaPageHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/19.
//

import Foundation

struct GuidePageHelper {
    static let  isLoadGuidePageVC:Bool = {
        let value = CacheHelper.readData(key: JsonLocalKey.isLoadGuidePageKey)
        if value == nil {
            return true
        }
        return false
    }()
    
    static func loadingGuidePageVCFinished () {
        CacheHelper.saveData(value: "1", key: JsonLocalKey.isLoadGuidePageKey)
    }
}
