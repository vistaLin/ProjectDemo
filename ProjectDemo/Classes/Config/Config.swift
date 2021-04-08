//
//  Config.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import Foundation

struct Config {
    #if DEBUG
    static let BaseURL = "http://uranus.dev.grdoc.org/API/"
    static let BASE_H5_URL = "http://uranush5.dev.grdoc.org/#/"
//    static let BASE_H5_URL =  "http://10.10.11.61:3000/#/"
    #elseif BETA
    static  let BaseURL = "http://uranus.beta.grdoc.org/API/"
    static  let BASE_H5_URL = "http://uranush5.beta.grdoc.org/#/"
    #else
    static   let BaseURL = "http://uranus.grdoc.org/API/"
    static let BASE_H5_URL = "https://uranush5.grdoc.org/#/"
    #endif
}
