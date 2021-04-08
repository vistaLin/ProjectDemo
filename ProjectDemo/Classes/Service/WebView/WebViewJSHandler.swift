//
//  WebViewViewModel.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/17.
//

import UIKit
import WebKit

class WebViewJSHandler:NSObject {
    var webView:WKWebView?
    // js调用的
    let jsApplyToken = "applyToken" // 调用只有给jstoken
    let jsApplySelectedAdcode = "applySelectedAdcode" // js调用后马上给她传递选择的地址 setSelectedAdcode
    let jsApplyLoginAdcode = "applyLoginAdcode" // js调用后 给她设置setLoginAdcode
    let jsToDetails = "toDetails" // js调用跳转详情 给了url
    
    // oc调用的
    let iOSSetSelectedAdcode = "setSelectedAdcode" // 传递选中的adCode
    let iOSSetLoginAdCode = "setLoginAdcode" // 传递登录的AdCode
    let iOSSetSort = "setSort" // 传递排序的字符串 desc:降序  asc 升序
    let iOSSetTag = "setTag" // ??传递的参数不知道??
    let iOSSetToken = "setToken" // 在js调用applyToken的时候给它
    
    private var jsCallMethods:Array<String>
    
    init(wkWebView:WKWebView) {
        webView = wkWebView
        jsCallMethods = [jsApplyToken, jsApplySelectedAdcode, jsApplyLoginAdcode, jsToDetails]
    }
}

extension WebViewJSHandler {
    func  registJSMethod() {
        for value in jsCallMethods {
            webView?.configuration.userContentController.add(self, name: value)
        }
    }
    func removeJSMethod() {
        for value in jsCallMethods {
            webView?.configuration.userContentController.removeScriptMessageHandler(forName: value)
        }
    }
}

// MARK: ios调用js的方法
extension WebViewJSHandler {
    
    func postJs(jsonStr:String?) {
         guard let jsonStr = jsonStr else {
            return
        }
        debugPrint(jsonStr)
        webView?.evaluateJavaScript(jsonStr, completionHandler: { (result, error) in
            debugPrint("result", result ?? "")
            debugPrint("error", error ?? ""  )
        })
    }
    
    func addJsParameter(value:String?) -> String {
        return "('\(value ?? "")')"
    }
    
    // iOS设置选中的adCode  在点击筛选区域之后
    func iOSCallSetSelectAdCode(_ adCode:String?) {
        guard let adCode = adCode else {
          return
        }
        postJs(jsonStr: iOSSetSelectedAdcode + addJsParameter(value: adCode))
    }
    
    func iOSCallSetLoginAdCode() {
        postJs(jsonStr: iOSSetLoginAdCode + addJsParameter(value: LoginViewModel.shared.loginModel?.adcode))
    }
    
    func iOSCallSetToken() {
        postJs(jsonStr: iOSSetToken + addJsParameter(value: LoginViewModel.shared.loginModel?.token))
    }
    
    func iOSCallSetSort(isAsc:Bool) {
        var str = "desc" // 默认降序
        if isAsc == true {
             str = "asc"  //升序
        }
        postJs(jsonStr: iOSSetSort + addJsParameter(value: str))
    }
    
}

extension WebViewJSHandler:WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("body==" , message.body, "name==" + message.name)
        switch message.name {
        case jsApplyToken:
             iOSCallSetToken()
            
        case jsApplyLoginAdcode:
            iOSCallSetLoginAdCode()
            
        case jsToDetails:
            let vc = YDYWebViewController.init()
            let dic = JsonHelper.dicFromJsonString(message.body as? String)
//            vc.url = URL.init(string: dic?["url"] as? String ?? "" )
//            vc.controllerTitle = dic?["title"] as? String
            vc.configureWithUrl(url: URL.init(string: dic?["url"] as? String ?? "" ), title: dic?["title"] as? String)
            UIViewController.getCurrentVC()?.navigationController?.pushViewController(vc, animated: true)
        
        case jsApplySelectedAdcode:
            iOSCallSetSelectAdCode(LoginViewModel.shared.selectAdCode)
        default:
            break
        }
    }
}
