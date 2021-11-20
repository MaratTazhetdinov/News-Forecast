//
//  LoadingScreenViewController.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 14.11.2021.
//

import UIKit

class LoadingScreenViewController: UIViewController {

    var router: RouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RCManager.shared.remoteConfigConnected = {
            DispatchQueue.main.async {
                self.goToMainScreen()
            }
        }
        RCManager.shared.connected()
    }
    
    func goToMainScreen() {
        self.router?.showInitialViewController()
    }
}
