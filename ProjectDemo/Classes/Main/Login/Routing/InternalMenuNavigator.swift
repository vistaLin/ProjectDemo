//
//  InternalMenuRoute.swift
//  Moments
//
//  Created by Jake Lin on 20/10/20.
//

import UIKit

struct InternalMenuNavigator: Navigating {
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String : String]) {
        // 拦截不允许打开地址
//        let togglesDataStore: TogglesDataStoreType = BuildTargetTogglesDataStore.shared
//        guard togglesDataStore.isToggleOn(BuildTargetToggle.debug) || togglesDataStore.isToggleOn(BuildTargetToggle.internal) else {
//            return
//        }

//        let navigationController = UINavigationController(rootViewController: UserProtocolViewController())
           navigate(to: UserProtocolViewController(), from: viewController, using: transitionType)
    }
}
