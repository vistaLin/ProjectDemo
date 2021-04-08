//
//  CodableUtils.swift
//  SwiftDemo
//
//  Created by yaode on 2020/12/30.
//

import Foundation

class CodableUtils {
    //  模型转json
    static func jsonToModel<T:Codable>(fromObject:T) -> String? {
        let encoder = JSONEncoder()
        let data = try!encoder.encode(fromObject)
        return String(data:data, encoding:.utf8)!
    }
    
    // json转模型
    static func fromJson<T:Codable>(_ json:String?, toClass:T.Type) ->T? {
        guard let json = json else {
            return nil
        }
        let jsonDecoder = JSONDecoder();
        return try? jsonDecoder.decode(toClass, from: json.data(using: .utf8)!)
    }
    
    /// 字典转模型
    static func toModel<T>(_ type: T.Type, value: Any?) -> T? where T: Decodable {
        guard let value = value else { return nil }
        return toModel(type, value: value)
    }

    /// 数组转模型
        public static func toModelArray<T>(_ array: Any?, to type: T.Type) -> [T]? where T: Decodable {
            
            guard let array = array else {
                print("❌ 传入的数据解包失败!")
                return nil
            }
            
            if !JSONSerialization.isValidJSONObject(array) {
                print("❌ 不是合法的json对象!")
                return nil
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else {
                print("❌ JSONSerialization序列化失败!")
                return nil
            }
            
            guard let arrayModel = try? JSONDecoder().decode([T].self, from: data) else {
                print("❌ JSONDecoder数组转模型失败!")
                return nil
            }
            
            return arrayModel
        }
    
}

/// 数组与字符串
extension CodableUtils {
    /// JSON字符串转数组
    func arrayFrom(jsonString:String) -> [Dictionary<String, Any>]? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        guard let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = array as? [Dictionary<String, Any>] else { return nil }
        return result
    }
}

/// 字典与json
extension CodableUtils {
    /// JSON字符串转字典
    func dictionaryFrom(jsonString:String) -> Dictionary<String, Any>? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = dict as? Dictionary<String, Any> else { return nil }
        return result
    }
    
    /// 字典转JSON字符串
    func jsonStringFrom(dict: Dictionary<String, Any>) -> String? {
        if (!JSONSerialization.isValidJSONObject(dict)) {
            print("字符串格式错误！")
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return nil }
        guard let jsonString = String(data: data, encoding: .utf8) else { return nil }
        return jsonString
    }
    /// 字典数组转JSON字符串
    func jsonStringFrom(array: [Dictionary<String, Any>?]?) -> String? {
        guard let array = array else { return nil }
        var jsonString = "["
        var i = 0
        let count = array.count
        for dict in array {
            guard let dict = dict else { return nil }
            if (!JSONSerialization.isValidJSONObject(dict)) {
                print("字符串格式错误！")
                return nil
            }
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return nil }
            guard let tmp = String(data: data, encoding: .utf8) else { return nil }
            jsonString.append(tmp)
            if i < count - 1 {
                jsonString.append(",")
            }
            i = i + 1
        }
        jsonString.append("]")
        return jsonString
    }
}
