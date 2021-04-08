//
//  CustomTextField.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/16.
//

import UIKit

class CustomTextField: UITextField {
    private var limitLength:Int?
    func limitTextLength(_ length:Int) {
        limitLength = length
        if self.delegate == nil {
            self.delegate = self
        }
    }
}

extension CustomTextField:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard limitLength != nil else {
            return true
        }
        guard let text = textField.text else{
            return true
        }
        let textLength = text.count + string.count - range.length
        return textLength <= limitLength!
    }
}
