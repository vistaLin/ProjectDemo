//
//  RequestProtocol.swift
//  SwiftDemo
//
//  Created by yaode on 2021/1/4.
//

import Foundation

protocol RequestDelegate : AnyObject{
    func requestSuccess(request:BaseRequest)
    func requestFaild(request:BaseRequest)
}
