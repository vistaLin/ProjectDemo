//
//  AppInfoHelper.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/12.
//

import Foundation

struct AppInfoHelper {
    static func getAppVersion() -> String {
        let dic:Dictionary? = Bundle.main.infoDictionary
        return dic?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}
