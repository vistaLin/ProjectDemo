//
//  NetKeyValueDao.swift
//  YIJI
//
//  Created by 张永 on 2017/10/24.
//  Copyright © 2017年 zy. All rights reserved.
//

import UIKit

class KeyValueDao: NSObject {

    class func saveCacheData(key: String,value: String?) {
        guard let value = value else {
            return
        }
        if let obj = realmOne.objects(RealmKeyValueModel.self).filter("key = %@",key).first {
            realmOne.beginWrite()
            obj.value = value
            try? realmOne.commitWrite()
        } else {
            let realmKeyValueModel = RealmKeyValueModel()
            realmKeyValueModel.key = key
            realmKeyValueModel.value = value
            try? realmOne.write {
                realmOne.add(realmKeyValueModel)
            }
        }
    }
    
    class func getCacheData(key: String) -> String? {

        let obj = realmOne.objects(RealmKeyValueModel.self).filter("key = %@",key).first
        return obj?.value
    }

    class func deleteOne(key: String) {

        let objs = realmOne.objects(RealmKeyValueModel.self).filter("key = %@",key)
        realmOne.beginWrite()
        realmOne.delete(objs)
        try? realmOne.commitWrite()
    }
    
    class func deleteAll() {
        let objs = realmOne.objects(RealmKeyValueModel.self)
        realmOne.beginWrite()
        realmOne.delete(objs)
        try? realmOne.commitWrite()
    }
    
}
