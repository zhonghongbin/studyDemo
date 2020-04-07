//
//  AttentionViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/4/7.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import WebKit

class AttentionViewController: UIViewController {
    //演示wkWebView加载网页
    var webView : WKWebView!
    //重载view
    override func loadView() {
        //创建网页加载偏好设置
        let prefence = WKPreferences()
        prefence.javaScriptEnabled = true
        
        //配置网页视图
        let webConfig = WKWebViewConfiguration()
        webConfig.preferences = prefence
        
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载网页
        let myURL = URL(string: "https://www.baidu.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}
extension AttentionViewController : WKNavigationDelegate{
    //视图开始加载时显示网络活动指示器
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    //载入结束时，关闭网络活动指示器
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    //阻止链接被点击
       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           if navigationAction.navigationType == .linkActivated {
               decisionHandler(.cancel)
               
               let alertController = UIAlertController(title: "Action not allowed", message: "Tapping on links is not allowed. Sorry!", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alertController, animated: true, completion: nil)
               return
               
           }
           
           decisionHandler(.allow)
       }
}

