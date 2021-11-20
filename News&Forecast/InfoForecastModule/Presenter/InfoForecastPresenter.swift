//
//  InfoForecastPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 06.11.2021.
//

import Foundation

protocol InfoForecastViewProtocol: AnyObject {
    func setWeather(_ weather: Weather?)
}

protocol InfoForecastPresenterProtocol: AnyObject {
    func setWeather()
}

class InfoForecastPresenter: InfoForecastPresenterProtocol {
    weak var view: InfoForecastViewProtocol?
    var router: RouterProtocol
    var weather: Weather?
    
    weak var delegate: CityForecastPresenter?
    
    init(view: InfoForecastViewProtocol, weather: Weather?, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.weather = weather
    }
    
    func setWeather() {
        self.view?.setWeather(weather)
    }
}


