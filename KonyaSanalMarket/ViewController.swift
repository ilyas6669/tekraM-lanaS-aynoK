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
    
    private lazy var url = URL(string: "")!
    private weak var webView: WKWebView!
    var ActInt = UIActivityIndicatorView()
    
    init (url: URL, configuration: WKWebViewConfiguration) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
        navigationItem.title = ""
    }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        print("Nicatalibli:ViewControlelr:\(Cache.website)")
        
        if Cache.website == ""{
            url = URL(string: "https://www.besyol.com.tr")!
        }else{
            url = URL(string: "\(Cache.website)")!
        }

        
        initWebView()
        webView.loadPage(address: url)
        
        ActInt.color = .black
        webView.addSubview(ActInt)
        ActInt.merkezKonumlamdirmaSuperView()
        ActInt.startAnimating()
        ActInt.hidesWhenStopped = true
        
    }
    
    private func initWebView() {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.addSubview(webView)
        self.webView = webView
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
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
        if let navigationController = navigationController {
            navigationController.pushViewController(vc, animated: false)
            return vc.webView
        }
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

