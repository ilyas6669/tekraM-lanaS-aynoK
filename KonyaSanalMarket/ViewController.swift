//
//  ViewController.swift
//  KonyaSanalMarket
//
//  Created by İlyas Abiyev on 6/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var ActInt: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let url = URL(string: "https://www.besyol.com.tr")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.addSubview(ActInt)
        ActInt.startAnimating()
        
        webView.navigationDelegate = self
        ActInt.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ActInt.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActInt.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ActInt.stopAnimating()
    }
    
    
}

