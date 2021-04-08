//
//  CacheHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/12.
//

import Foundation

struct CacheHelper {
    static func saveData(value:Any?, key:String?) {
        guard let value = value else {
            return
        }
        guard let key = key else {
            return
        }
        
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func readData(key:String?) -> Any? {
        guard let key = key else {
            return nil
        }
        return UserDefaults.standard.value(forKey: key)
    }
    
    static func removeData(key:String?) {
        guard let key = key else {
            return
        }
        return UserDefaults.standard.removeObject(forKey: key)
    }
}
