//
//  RealmKeyValueModel.swift
//  YIJI
//
//  Created by 张永 on 2017/7/7.
//  Copyright © 2017年 zy. All rights reserved.
//

import UIKit
import RealmSwift

class RealmKeyValueModel: Object {

    
    @objc dynamic var key = ""
    @objc dynamic var value = ""

    var age = RealmOptional<Int>()

    override class func primaryKey() -> String? {
        return "key"
    }

    
}

