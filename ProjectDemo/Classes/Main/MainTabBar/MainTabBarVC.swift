//
//  MainTabBarVC.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        addChildsVC()
        tabBar.items?.forEach({ (unSelItem) in
            unSelItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.colorWith(hex: "#666666"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular)], for: .normal)
        })
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.defaultMainColor
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
//        tabBar.backgroundImage = UIImage()
  
    }
}

// MARK: Private
extension MainTabBarVC {
    func addChildsVC() {
        let rankingVC = RankingVC()
        rankingVC.configureWithUrl(url: URL.init(string: Config.BASE_H5_URL + "ranking"))
        let progressVC = ProgressVC()
        progressVC.configureWithUrl(url: URL.init(string: Config.BASE_H5_URL + "progress"))
        
        let titleArray = ["进展", "排行"]
        let normalImageArray = ["Progress", "ranking"]
        let selectImageArray = ["progress_select", "ranking_select"]
        let vcArray = [progressVC, rankingVC];
        for (index, vc) in vcArray.enumerated() {
            addChildVC(vc, title: titleArray[index], normalImageName: normalImageArray[index], selectedImageName: selectImageArray[index])
        }
    }
    
    func addChildVC(_ childVC:UIViewController, title:String, normalImageName:String, selectedImageName:String)  {
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: normalImageName)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)
        let navi = CustomNavigationVC.init(rootViewController: childVC)
        self.addChild(navi)
    }
}

extension MainTabBarVC:UITableViewDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.items?.forEach({ (unSelItem) in
            if unSelItem == item {
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.colorWith(hex: "#15BA88"),NSAttributedString.Key.font: UIFont.semibold(10)], for: .normal)
            } else {
                unSelItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.colorWith(hex: "#666666"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .regular)], for: .normal)
            }
        })
    }
}


