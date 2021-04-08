//
//  LoginModel.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/11.
//

import Foundation
import HandyJSON
struct LoginModel:Codable, HandyJSON {
    var uid:String? // 用户id
    var status:Int? // 1为登录成功,其余状态通知展示后台msg数据 {1:SUC, 2:AccountNonExistent, 3:CaptchaError, 4:PasswordError}
    var token:String?
    var level:Int? //{0:country, 1:province, 2:city, 3:area, 9:orgbg, 10:unknown}  请求的等级
    var msg:String? // 错误是展示的信息
    var creator:String?  // 创建者
    var adcode:String?
    
}
