//
//  YRZWebViewController.swift
//  Beauty
//
//  Created by 张永 on 16/3/15.
//  Copyright © 2016年 zy. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

///用于web页面的加载
class YDYWebViewController: BaseViewController {
    var url: URL?
    var controllerTitle: String?
    public var viewModel:WebViewJSHandler!
    var isAscending = false // 默认为降序
    var webContentView:CustomWebContentView?
    /**
     配置web页面
     - Parameter url: url页面地址
     - Parameter title: web标题
     - Parameter bottomHeight: 距离底部的距离
     */
    func configureWithUrl(url: URL?,title: String? = "加载中...") {
        self.controllerTitle = title
        guard url != nil else {
            return
        }
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.controllerTitle
        setupUI()
        setupData()
        // 默认进入为降序
        addRightBarItem(imageName: "descending")
    }

    deinit {
        webContentView?.removeObserve()
        viewModel?.removeJSMethod()
    }
}

extension YDYWebViewController {
    func setupUI()  {
        webContentView = CustomWebContentView.init()
        view.addSubview(webContentView!)
        webContentView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    func setupData() {
        webContentView?.loadURL(url)
        viewModel = WebViewJSHandler.init(wkWebView: webContentView!.wkWebView!)
        viewModel.registJSMethod()
    }
}

// MARK:除了首页,都需要这个排序
extension YDYWebViewController {
    @objc override func rightBarClicked() {
        isAscending = !isAscending
        if isAscending == true {
            self.addRightBarItem(imageName: "descending")
        } else {
            self.addRightBarItem(imageName: "ascending")
        }
        viewModel.iOSCallSetSort(isAsc: isAscending)
    }
}

// MARK: 给首页两个页面调用的
extension YDYWebViewController {
    
}



