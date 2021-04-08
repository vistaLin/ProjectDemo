//
//  JsonHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/12.
//

import Foundation

    struct JsonHelper {
        // json转字典
        static func dicFromJsonString(_ str:String?) ->  [String : Any]?{
            guard let str = str else {
                return nil
            }
            let data = str.data(using: String.Encoding.utf8)
            
            if let dic = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                return dic
            }
            return nil
        }
        // json转数组
        static func arrayFromJsonString(_ jsonStr:String?) -> Array<Any>? {
            guard let jsonStr = jsonStr else  {
                return nil
            }
            let data = jsonStr.data(using: String.Encoding.utf8)
            if let array = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<Any> {
                return array
            }
            return nil
        }
        
        //字典转Data
         func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
            if (!JSONSerialization.isValidJSONObject(jsonDic)) {
                print("is not a valid json object")
                return nil
            }
            //利用自带的json库转换成Data
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
            //Data转换成String打印输出
            let str = String(data:data!, encoding: String.Encoding.utf8)
          //  输出json字符串
            print("Json Str:\(str!)")
            return data
        }
    }
