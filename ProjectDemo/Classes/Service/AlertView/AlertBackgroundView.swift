//
//  AlertBackgroundView.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/15.
//

import UIKit



class AlertBackgroundView: UIView {
    typealias block = () -> ()
     var dismissBlock:block?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.colorWith(hex: "#000000", alpha: 0.4)
        self.alpha = 0
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(tap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDismissBlock(block:@escaping block) {
        self.dismissBlock = block
    }
    @objc func dismiss() {
        if let blk = self.dismissBlock {
            blk()
        }
    }
}
