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
        guard let _ = navigationAction.request.url else {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        debugPrint("弹框了")
        completionHandler()
    }
    
}
