//
//  MineView.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/11.
//

import UIKit

class MineView: UIView {

//    var avatarImageView:UIImageView!
//    var nameLabel:UILabel!
//    var cacheSizeLabel:UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var exitLoginButton: UIButton!
    
    var name:String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.addConner(value: 74/2)
        backgroundColor = .white
        versionLabel.text = AppInfoHelper.getAppVersion()
        exitLoginButton.layoutEdgeInset(style: .top, margin: 5)
        exitLoginButton.addTarget(self, action: #selector(exitLoginClicked), for: .touchUpInside)
    }
    
}

// MARK: Private
extension MineView {
    private func setupUI() {
       
    }
}

extension MineView {
    @objc func exitLoginClicked() {
        ProgressHUD.showMessage("退出成功，进入登录页面。")
        LoginViewModel.shared.exitLogin()
    }
}
