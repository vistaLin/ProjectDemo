//
//  CustomWebView.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/15.
//

import UIKit
import WebKit

class CustomWebContentView: UIView {
    var wkWebView:CustomWebView? // 注意在deinit需要调用的view 是可选值  否则当vc被移除的时候会导致崩溃
    var endPayRedirectURL:String? // 避免微信支付重定向后值为空 空返回就会是空白页面
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect.zero)
        progressView.progressTintColor = .defaultMainColor
        progressView.trackTintColor = UIColor.clear
        progressView.progress = 0.1
        return progressView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addObserve()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomWebContentView {
    func loadURL(_ url:URL?) {
        guard let url = url else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        wkWebView!.load(request as URLRequest)
    }
    func removeObserve()  {
        wkWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension CustomWebContentView {
    private func addObserve() {
        wkWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "estimatedProgress") {
              progressView.isHidden = wkWebView!.estimatedProgress == 1
              progressView.setProgress(Float(wkWebView!.estimatedProgress), animated: false)
        }
    }
}

extension CustomWebContentView {
    func setupUI() {
        
//        let configuretion = WKWebViewConfiguration()
//        //初始化偏好设置属性：preferences
//        configuretion.preferences = WKPreferences();
//            //The minimum font size in points default is 0;
//        configuretion.preferences.minimumFontSize = 10;
//            //是否支持JavaScript
//        configuretion.preferences.javaScriptEnabled = true;
//        configuretion.userContentController = WKUserContentController()
//        wkWebView = CustomWebView(frame: CGRect.zero, configuration: configuretion)
//        wkWebView!.navigationDelegate = self
//        wkWebView!.uiDelegate = self
        wkWebView = CustomWebViewPool.shared.getReusedWebView(forHolder: "webview" as NSString)
        wkWebView!.navigationDelegate = self
        wkWebView!.uiDelegate = self
        addSubview(wkWebView!)
        wkWebView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        addSubview(progressView)
        bringSubviewToFront(progressView)
        progressView.snp.makeConstraints {(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
}

extension CustomWebContentView:WKNavigationDelegate,WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("载入失败")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let reqUrl = url.absoluteString
        // 唤起支付宝  alipays添加在info的URLtype  方便支付宝取消支付返回
        if ((reqUrl.hasPrefix("alipays://")) == true) || ((reqUrl.hasPrefix("alipay://")) == true) {
          // 解决跳转到本地支付宝App不返回的问题  解码URL 将alipays替换成功自己的URL Schemes  在taget -> info -> URL Types设置
            let aliURLString = reqUrl.urlDecoded().replacingOccurrences(of: "alipays", with: Config.jiaYiDoctorScheme)
            let openedURL = URL.init(string: aliURLString.urlEncoded())
          // 支付宝判定是否打开很容易导致失败 所以是直接打开
            let bSucc = UIApplication.shared.openURL(openedURL!)
            if bSucc == false {
              ProgressHUD.showMessage("您还未安装支付宝App,请安装后重试")
            }
        }
        
        var redirectUrl:String?
        // 微信的必须将redirect_url也配置为支付域名 否则也会报商户错误
        if ((reqUrl.hasPrefix("https://wx.tenpay.com/cgi-bin/mmpayweb-bin/checkmweb")) == true && (reqUrl.hasSuffix("redirect_url=\(Config.PayDomain)://")) == false) {
          decisionHandler(.cancel)
          // 添加自己的app的scheme方便回调  如果不更新返回会跳转到浏览器去
            if ((reqUrl.contains("redirect_url=")) != nil) {
                let array = reqUrl.components(separatedBy: "redirect_url=")
                if array.count == 2 {
                endPayRedirectURL = array[1]
                redirectUrl = array[0] + "redirect_url=\(Config.PayDomain)://"
            }
          } else {
            redirectUrl = reqUrl +  "redirect_url=\(Config.PayDomain)://"
          }
          // 设置请求信息 避免会跳转浏览器说商家信息格式错误  微信也需要重新定向加载一次
          let newRequest:NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: redirectUrl!)!)
          newRequest.allHTTPHeaderFields = navigationAction.request.allHTTPHeaderFields
          newRequest.setValue(Config.PayDomain, forHTTPHeaderField: "Referer")
          newRequest.url = URL.init(string: redirectUrl!)
          webView.load(newRequest as URLRequest)
          return
        }
    
        
        let scheme:String = navigationAction.request.url?.scheme ?? ""
        if scheme != "https" && scheme != "http" {
          decisionHandler(.cancel)
          // 加载微信页面钱要先加载自己的结果页面  但是结果页面返回会有空白页面
          //如果不展示空白页面可以在页面微信支付结果回调后发送通知刷新页面 这样不会有空白页面
          if scheme == "weixin" {
            if endPayRedirectURL != nil {
              // 必须要再次解码 否则返回为空白页面 但是在返回还是weixin标题的空白页 只有appdelega添加这个结果刷新才不会有空白页
               webView.load(URLRequest.init(url: URL.init(string: endPayRedirectURL!.urlDecoded())!))
            }
          }
          // 打开微信支付
            if reqUrl.hasPrefix("weixin://") {
                if UIApplication.shared.canOpenURL(url) == false {
              ProgressHUD.showMessage("您还未安装微信App,请安装后重试")
            } else {
               UIApplication.shared.openURL(navigationAction.request.url!)
            }
          }
          return
        }
        decisionHandler(.allow)
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        debugPrint("弹框了")
        completionHandler()
    }
    
}
