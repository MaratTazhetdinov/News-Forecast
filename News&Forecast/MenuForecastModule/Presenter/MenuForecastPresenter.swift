//
//  MainForecastPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import Foundation

protocol MenuForecastViewProtocol: AnyObject {
    
}

protocol MenuForecastViewPresenterProtocol: AnyObject {
    init(view: MenuForecastViewProtocol, router: RouterProtocol)
    func presentCityForecast()
    func presentMapForecast()
}

class MenuForecastPresenter: MenuForecastViewPresenterProtocol {
    
    weak var view: MenuForecastViewProtocol?
    var router: RouterProtocol?
    
    required init(view: MenuForecastViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func presentCityForecast() {
        router?.showSelectCity()
    }
    
    func presentMapForecast() {
        router?.showMapForecast()
    }
}


