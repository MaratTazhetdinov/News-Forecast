//
//  MainForecastView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import UIKit
import UserNotifications
import Alamofire
import SwiftyJSON

class MenuForecastView: UIViewController {
    
    var presenter: MenuForecastViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
        
    @IBAction func buttonByCityTap(_ sender: Any) {
        self.presenter.presentCityForecast()
    }
    
    @IBAction func buttonByLocationTap(_ sender: Any) {
        self.presenter.presentMapForecast()
    }
}

extension MenuForecastView: MenuForecastViewProtocol {
    
}



