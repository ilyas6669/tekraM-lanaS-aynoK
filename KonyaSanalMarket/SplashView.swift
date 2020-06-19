//
//  SplashView.swift
//  KonyaSanalMarket
//
//  Created by İlyas Abiyev on 6/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SplashView: UIViewController {
    
    let imgLogo : UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo1"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return img
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        view.backgroundColor = .white
        addSubview()
        addConstraint()
        activityIndicator.startAnimating()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.Connection(){
            
            perform(#selector(toHomePage), with: nil,afterDelay: 2)
            
        }
            
        else{
            
            self.Alert(Message: "Cihazınız internete bağlı değil")
        }
        
    }
    
    func addSubview() {
        view.addSubview(imgLogo)
        view.addSubview(activityIndicator)
    }
    
    
    func addConstraint() {
        imgLogo.merkezKonumlamdirmaSuperView()
        activityIndicator.topAnchor.constraint(equalTo: imgLogo.bottomAnchor,constant: 5).isActive = true
        activityIndicator.merkezXSuperView()
        
    }
    
    @objc func toHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "Uyarı", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
