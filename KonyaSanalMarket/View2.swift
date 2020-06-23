//
//  View2.swift
//  KonyaSanalMarket
//
//  Created by İlyas Abiyev on 6/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import WebKit

class View2: UIViewController,WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var popupWebView : WKWebView!
    
    @IBOutlet weak var ActInt: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.besyol.com.tr")
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.navigationDelegate = self
        
        ActInt.startAnimating()
        ActInt.hidesWhenStopped = true
    }
    
    
    private func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        // allow facebook to open the login popup
        prefs.javaScriptCanOpenWindowsAutomatically = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        popupWebView = WKWebView(frame: .zero, configuration: config)
        view.addSubview(popupWebView)
        self.webView = popupWebView
        popupWebView.navigationDelegate = self
        popupWebView.uiDelegate = self
        popupWebView.translatesAutoresizingMaskIntoConstraints = false
        return popupWebView
    }
    
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        // if the main webView loads a new page (e.g. due to succesful facebook login)
        // remove the popup
        if (popupWebView != nil) {
            popupWebView?.removeFromSuperview()
            popupWebView = nil
        }
    }
    

    

}
