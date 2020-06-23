//
//  ViewController.swift
//  KonyaSanalMarket
//
//  Created by İlyas Abiyev on 6/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {
    
    
    private lazy var url = URL(string: "https://www.besyol.com.tr")!
    private weak var webView: WKWebView!
    var popupWebView : WKWebView!
    
    var ActInt = UIActivityIndicatorView()
    
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back3"), for: .normal)
        btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return btn
    }()
    
    let btnRight : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "arrow"), for: .normal)
        btn.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        return btn
    }()
    
    let btnRefresh : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "refresh3"), for: .normal)
        btn.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    let btnCancel : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "close2"), for: .normal)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    init (url: URL, configuration: WKWebViewConfiguration) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
        navigationItem.title = ""
    }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Nicatalibli:ViewControlelr:\(Cache.website)")
        
        
        initWebView()
        webView.loadPage(address: url)
        
        ActInt.color = .black
        webView.addSubview(ActInt)
        ActInt.merkezKonumlamdirmaSuperView()
        ActInt.startAnimating()
        ActInt.hidesWhenStopped = true
        
        
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if Cache.website == ""{
            url = URL(string: "https://www.besyol.com.tr")!
        }else{
            url = URL(string: "\(Cache.website)")!
        }
    }
    
    private func initWebView() {
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
        view.addSubview(bottomView)
        bottomView.addSubview(btnLeft)
        bottomView.addSubview(btnRight)
        bottomView.addSubview(btnCancel)
        bottomView.addSubview(btnRefresh)
        
        
        
        if #available(iOS 11.0, *) {
            popupWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            popupWebView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
            popupWebView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
            popupWebView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
            
            _ = bottomView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
            
            _ = btnLeft.anchor(top: bottomView.topAnchor, bottom: bottomView.bottomAnchor, leading: bottomView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
            _ = btnRight.anchor(top: bottomView.topAnchor, bottom: bottomView.bottomAnchor, leading: btnLeft.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0))
            
            btnCancel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,constant: -7).isActive = true
            btnCancel.merkezYSuperView()
            
            
            btnRefresh.trailingAnchor.constraint(equalTo: btnCancel.leadingAnchor,constant: -7).isActive = true
            btnRefresh.merkezYSuperView()
            
    
            
            
            
        }else{
            popupWebView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            popupWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            popupWebView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
            popupWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            
            _ = bottomView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
            
            _ = btnLeft.anchor(top: bottomView.topAnchor, bottom: bottomView.bottomAnchor, leading: bottomView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
            _ = btnRight.anchor(top: bottomView.topAnchor, bottom: bottomView.bottomAnchor, leading: btnLeft.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0))
            
            btnCancel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,constant: -7).isActive = true
            btnCancel.merkezYSuperView()
            
           btnRefresh.trailingAnchor.constraint(equalTo: btnCancel.leadingAnchor,constant: -7).isActive = true
           btnRefresh.merkezYSuperView()
            
            
        }
        
        
    }
    
    @objc func leftAction() {
        if webView.canGoBack {
            webView.goBack()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func rightAction() {
        if webView.canGoForward {
            webView.goForward()
        }
          webView.goForward()
    }
    
    
    @objc func refreshAction() {
         webView.reload()
        
    }
    
    @objc func cancelAction() {
         webView.stopLoading()
    }
    
    
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let host = webView.url?.host else { return }
        navigationItem.title = host
        ActInt.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ActInt.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ActInt.stopAnimating()
    }
    
    
    
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard   navigationAction.targetFrame == nil,
            let url =  navigationAction.request.url else { return nil }
        let vc = ViewController(url: url, configuration: configuration)
        vc.view.backgroundColor = .white
        if let navigationController = navigationController {
            navigationController.pushViewController(vc, animated: false)
            return vc.webView
            
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        return nil
        
    }
    
    
}

extension WKWebView {
    func loadPage(address url: URL) { load(URLRequest(url: url)) }
    func loadPage(address urlString: String) {
        guard let url = URL(string: urlString) else { return }
        loadPage(address: url)
    }
}

