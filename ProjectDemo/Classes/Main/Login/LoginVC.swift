//
//  LoginVC.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/8.
//

import UIKit
import Moya

class LoginVC: BaseViewController {
    var nameTextField:CustomTextField!
    var passwordTextField:CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}


// MARK: Private
extension LoginVC {
    private  func setupUI() {
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "loginBackgoundImage"))
        bgImageView.isUserInteractionEnabled = true
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let iconImageView = UIImageView.init(image: UIImage.init(named: "loginIcon"))
        bgImageView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo((70 + SizeHelper.statusBarHeight))
            make.centerX.equalToSuperview()
        }
        
        let titleLabel = UILabel.init(fontSize: 20,colorHex: "#FFFFFF", text: "中国家医管理端")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        nameTextField = getTextField(placeholder: "请输入用户名")
        nameTextField.limitTextLength(20)
        bgImageView.addSubview(nameTextField)
        bgImageView.bringSubviewToFront(nameTextField)
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(96)
            make.height.equalTo(52)
            make.width.equalTo(SizeHelper.autoWidth(300))
            make.centerX.equalToSuperview()
        }
        
        passwordTextField = getTextField(placeholder: "请输入用户密码")
        passwordTextField.keyboardType = .numberPad
        passwordTextField.limitTextLength(6)
        bgImageView.addSubview(passwordTextField)
        bgImageView.bringSubviewToFront(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.height.width.centerX.equalTo(nameTextField)
        }
        
        let loginButton = UIButton.init(fontSize: 20, colorHex: UIColor.defaultMainHex, text: "登录")
        loginButton.backgroundColor = .white
        loginButton.titleLabel?.font = UIFont.semibold(20)
        loginButton.addConner()
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        bgImageView.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(nameTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
        }
        
        let loginProtocolLabel = UILabel.init(fontSize: 12, colorHex: "#FFFFFF", text: "")
        loginProtocolLabel.attributedText = NSMutableAttributedString.attributedSubColor("登录即代表阅读并同意", "《用户协议》", UIColor.white, UIFont.semibold(12))
        loginProtocolLabel.setTapGesture {[unowned self] (view) in
            AppRouter.shared.route(to: URL(string: "\(UniversalLinks.baseURL)InternalMenu"), from: self, using: .show)
            
//            self.navigationController?.pushViewController(UserProtocolViewController(), animated: true)
        }

        bgImageView.isUserInteractionEnabled = true
        bgImageView.addSubview(loginProtocolLabel)
        loginProtocolLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.centerX.equalToSuperview()
        }
        
        let phoneNumberLabel = UILabel.init(fontSize: 12, colorHex: "#FFFFFF", text: "客服电话 4008-010-133")
        bgImageView.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginProtocolLabel.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    private  func getTextField(placeholder:String) -> CustomTextField {
        let textField = CustomTextField.init(fontSize: 16, colorHex: "#FFFFFF")
        textField.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.backgroundColor = UIColor.colorWith(hex: "#FFFFFF'", alpha: 0.2)
        textField.addConner()
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 0))
        textField.leftViewMode = .always
        textField.tintColor = .white
        
        return textField
    }
}

// MARK: Action
extension LoginVC {

    @objc func loginButtonClicked() {
        
//        国家卫生健康委员会  845503
//
//
//        江苏省卫计委  887151
//
//        苏州市卫计委  346588
//
//        张家港市卫计局  285023
//
//
//
//        四川省卫计委  868423
//
//        成都市卫计委  100101
//
//        武侯区卫计局  683182
//
//
//        河南省卫计委  887151
//
//        周口市卫计委  871510
//
//        商水县卫计局  151326
//
//        固始县卫计局  758871 （直辖县）

//
        #if DEBUG
        nameTextField.text = "四川省卫计委"
        passwordTextField.text = "868423"
        #endif
        
        let name:String? = nameTextField.text?.removeHeadAndTailSpace
        let password:String? = passwordTextField.text?.removeHeadAndTailSpace
        if ValidateKit.isSpaceString(name) {
            ProgressHUD.showMessage("用户名不能为空")
            return
        }
        if ValidateKit.isSpaceString(password) {
            ProgressHUD.showMessage("密码不能为空")
            return
        }
       
        
       // 单纯moya的使用方式
//       let provider = MoyaProvider<LoginApi>()
//        provider.request(.login(name!, password!)) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let model = LoginModel.deserialize(from: try! moyaResponse.mapString())
//                //let model:LoginModel? = CodableUtils.fromJson(try! moyaResponse.mapString() as! String, toClass: LoginModel.self)
//                do {
//                    try print("result.mapJSON() = \(moyaResponse.mapJSON())")
//                } catch {
//                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(moyaResponse))")
//                }
//            case let .failure(error): break
//
//            }
//        }
        
   
        
//        let request:BaseRequest = BaseRequest.init()
//        request.url = "ManageLogin"
//        request.parameterDic = ["account":name!, "password":password!.MD5Encrypt()]
//        request.isLoading = true
//        NetworkHelper.postRequest(request: request) {(response) in
//            let model:LoginModel? = CodableUtils.fromJson(response, toClass: LoginModel.self)
//            if model == nil {
//                return
//            }
//            if model?.status == 1 {
//                LoginViewModel.shared.loginSuccess(json: response)
//                UIApplication.shared.keyWindow?.rootViewController = MainTabBarVC.init()
//                ProgressHUD.showMessage("登录成功")
//            } else {
//                ProgressHUD.showMessage(model?.msg)
//            }
//        } failure: { _ in
//
//        }
      
    }
}
