//
//  PickerViewSelectProtocol.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/16.
//

import Foundation

protocol CustomPickerViewProtocol: NSObjectProtocol {
    func sureButtonClicked(selectModel:PickerModel?, pickerView:ChoosePickerView)
    func cancelButtonClicked()
}
