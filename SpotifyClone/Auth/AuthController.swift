
//
//  LoginController.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

class AuthController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    func setupView() {
        let authView = AuthView(frame: self.view.bounds)
        
        self.view.addSubview(authView)
    }
    
}
