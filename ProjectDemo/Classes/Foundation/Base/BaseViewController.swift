//
//  BaseViewController.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if navigationController?.viewControllers.count ?? 0 > 1 {
            setupLeftBarItem(imageName: "backBarItem")
        }
    }

}

extension BaseViewController {
    func setupLeftBarItem(imageName:String = "") {
        navigationItem.leftBarButtonItem = UIBarButtonItem.setupItem(imageName: imageName, target: self, action: #selector(leftBarClicked))
    }
    
    func addRightBarItem(imageName:String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem.setupItem(imageName:imageName, target: self, action: #selector(rightBarClicked), isLeft: false)
    }
    @objc func leftBarClicked()  {
        navigationController?.popViewController(animated: true)
    }
    @objc func rightBarClicked() {
        
    }
}
