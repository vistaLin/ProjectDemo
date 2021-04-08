//
//  ObjectWrapper.swift
//  TipsOfSwift
//
//  Created by yongzhang on 15/10/13.
//  Copyright © 2015年 yongzhang. All rights reserved.
//

import UIKit

class ObjectWrapper: NSObject {

    var tapGestureAction : TapGestureAction?
    init(tapGestureAction:@escaping TapGestureAction) {
        super.init()
        self.tapGestureAction = tapGestureAction
    }
    override init() {
        super.init()
    }
}

class WrapperObject<T>: NSObject {
    var info: T
    init(info: T) {
        self.info = info
        super.init()
    }
}
