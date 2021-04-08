//
//  ValidateKit.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/9.
//

import Foundation

class ValidateKit {
    
    
    class func isSpaceString(_ str:String?) -> Bool{
        if str == nil || str?.count == 0 {
            return true
        }
        return false
    }
}
