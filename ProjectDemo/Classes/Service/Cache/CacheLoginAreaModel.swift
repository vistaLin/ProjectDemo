//
//  CacheLoginAreaModel.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/17.
//

import Foundation

struct CacheLoginAreaModel {
    static func getAreaName() -> String? {
        return CacheHelper.readData(key: JsonLocalKey.currentLoginAreaModel) as? String
    }
    static func saveAreaName(name:String?) {
        guard let name = name else {
            return
        }
        CacheHelper.saveData(value: name, key: JsonLocalKey.currentLoginAreaModel)
    }
    static func removeAreaData() {
        CacheHelper.removeData(key: JsonLocalKey.currentLoginAreaModel)
    }
}
