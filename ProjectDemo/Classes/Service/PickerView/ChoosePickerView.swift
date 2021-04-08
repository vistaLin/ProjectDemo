//
//  ChoosePickerView.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/15.
//

import UIKit

class ChoosePickerView: UIView {
    var pickerView:UIPickerView!
    weak var delegate:CustomPickerViewProtocol?
    
    let buttonWidth = 50
    private var dataArray:Array<PickerModel> = []
    private let rowHeight = 45
    private var selectRow = 0;
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addConner(byRoundingCorners: [.topLeft, .topRight])
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChoosePickerView {
    func setupUI() {
        let topView = UIView.init()
        addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(45)
        }
        
        let cancelButton = getButton(title: "取消")
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        topView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.top.height.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        let sureButton = getButton(title: "确定")
        sureButton.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        topView.addSubview(sureButton)
        sureButton.snp.makeConstraints { (make) in
            make.right.top.height.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.colorWith(hex: "#E5E5E5")
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        pickerView = UIPickerView.init()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
        pickerView?.snp.makeConstraints({ (make) in
            make.left.width.bottom.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
        })
        
    }
    
    private func getButton(title:String) -> UIButton {
        return UIButton.init(fontSize: 15, colorHex: "#24C793", text: title)
    }
}

extension ChoosePickerView {
    
    func refresh(modelArray:Array<PickerModel>?, selectCurrentRow: Int = 0)  {
        selectRow = selectCurrentRow
        guard let array = modelArray else {
            return
        }
        dataArray = array
        pickerView.reloadAllComponents()
    }
}

extension ChoosePickerView {
    @objc func cancelButtonClicked() {
        if delegate != nil {
            delegate?.cancelButtonClicked()
        }
    }
    
    @objc func sureButtonClicked() {
        if delegate != nil {
            delegate?.sureButtonClicked(selectModel: dataArray[selectRow], pickerView: self)
        }
    }
}

extension ChoosePickerView:UIPickerViewDelegate {
   
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
       var tempView = view
        if tempView == nil  {
            tempView = UIView()
        }
        let model = dataArray[row]
        let label = UILabel.init(fontSize: 21, colorHex: "#333333", text: model.title ?? "")
        label.frame = CGRect.init(x: 0, y: 0, width: Int(self.bounds.size.width), height: rowHeight)
        label.backgroundColor = .white
        label.textAlignment = .center
        tempView?.addSubview(label)
        return tempView!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectRow  = row
    }
}

extension ChoosePickerView:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
}
