//
//  ProgressVC.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit
import WebKit

class ProgressVC: HomeBaseViewController{
//    var isFirstFetchAreaData = true // 每次点击获取都是true 第一次获取成功后就是false  因为每次获取区域结构都要获取两次
    var areaCodeArray:Array<Any>? // 获取到的区域area
    var areaModelArray:Array<AreaModel>?
    lazy var alertViewManager:AlertViewManager = {
        return AlertViewManager.init()
    }()
    lazy var pickerView:ChoosePickerView = {
        let view = ChoosePickerView()
        view.delegate = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //区县级不展示
        if LoginViewModel.shared.loginModel?.level == 3 {
            
        } else {
            self.addRightBarItem(imageName: "progress_rightBar")
        }
        // 只有为空才去获取区域名称 否则就直接读取缓存 减少请求
        if LoginViewModel.shared.areaName == nil {
            fetchAreaData()
        }
        
    }
}

extension ProgressVC {
    func fetchAreaData() {
        let request = BaseRequest.init()
        if areaCodeArray == nil {
            request.parameterDic = ["adcodes":[LoginViewModel.shared.loginModel?.adcode ?? ""]]
        } else {
            request.parameterDic = ["adcodes":areaCodeArray!]
        }
        request.url = "GetAdcodeInfo"
        NetworkHelper.postRequest(request: request) {[weak self] (response) in
            let dic = JsonHelper.dicFromJsonString(response)
            let items:Array? = dic?["items"] as? Array<Dictionary<String, Any>?>
            if items == nil {
                return
            }
            if items!.count == 0 {
                return
            }
            
            if self?.areaCodeArray == nil {
                let children = items![0]!["children"]
                self?.areaCodeArray = children as? Array<Any>
                if LoginViewModel.shared.areaName == nil {
                    LoginViewModel.shared.areaName = items![0]!["name"] as? String
                    self?.navigationItem.title = LoginViewModel.shared.areaName
                    CacheLoginAreaModel.saveAreaName(name: items![0]!["name"] as? String )
                } else {
                    if (self?.areaCodeArray != nil) && (self?.areaCodeArray!.count ?? 0 > 0) {
                        self?.fetchAreaData()
                    }
                }
                return
            } else {
                self?.areaModelArray = CodableUtils.toModelArray(items, to: AreaModel.self)
            }
            DispatchQueue.main.async {
                self?.showChoosePickerView()
            }
        } failure: { (Error) in
            
        }

    }
    func showChoosePickerView() {
        guard let array = areaModelArray else {
            return
        }
        var modelArray:Array<PickerModel> = []
        for model in array {
            var tempModel = PickerModel()
            tempModel.id = model.adcode
            tempModel.title = model.name
            modelArray.append(tempModel)
        }
        if alertViewManager.isShowAlertView {
            
        } else {
            pickerView.frame = CGRect.init(x: 0, y: SizeHelper.screenHeight, width: SizeHelper.screenWidth, height: 304)
            alertViewManager.showAlertView(view: pickerView, changeFrame: CGRect.init(x: 0, y: SizeHelper.screenHeight - 304, width: SizeHelper.screenWidth, height: 304))
        }
        pickerView.refresh(modelArray: modelArray)
        
    }
}

// MARK: Action
extension ProgressVC {
    override func rightBarClicked() {
        if areaModelArray != nil {
            showChoosePickerView()
        } else {
            self.fetchAreaData()
        }
    }
}

extension ProgressVC:CustomPickerViewProtocol {
    func sureButtonClicked(selectModel: PickerModel?, pickerView: ChoosePickerView) {
        var model:AreaModel?
        for (_, tempModel) in areaModelArray!.enumerated() {
            if tempModel.adcode == selectModel?.id {
                model = tempModel
                break
            }
        }
        if model == nil {
            return
        }
        LoginViewModel.shared.selectAdCode = model?.adcode // 为了保存在切换页面或者前端主动调用的时候
        if model?.level != nil {
            // 避免后台返回别的数据
            LoginViewModel.shared.selectLevel = model?.level
        }
        LoginViewModel.shared.areaName = model?.name
        self.navigationItem.title = model?.name
        viewModel.iOSCallSetSelectAdCode(model?.adcode)
        alertViewManager.dismiss(changeFrame: nil)
    }
    
    func cancelButtonClicked() {
        alertViewManager.dismiss(changeFrame: nil)
    }
}
