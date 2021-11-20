//
//  CityForecastPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import Foundation

protocol CityForecastViewProtocol: AlertedViewProtocol {
}

protocol CityForecastPresenterProtocol: AnyObject {
    func selectCity(_ city: String)
    func presentInfoForecast(weather: Weather)
    func presentHistoryRequest()
}

class CityForecastPresenter: CityForecastPresenterProtocol {

    weak var view: CityForecastViewProtocol?
    var router: RouterProtocol
    var networkService: NetworkServiceProtocol?
    
    
    init(view: CityForecastViewProtocol, service: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = service
    }
    
    func selectCity(_ city: String) {
        if city.count == 0 || !city.isValidCity() {
            self.view?.showAlert(message: "Incorrect city")
        }
        else {
            self.networkService?.getForecast(city: city) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        let currentDate = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy"
                        let date = formatter.string(from: currentDate)
                        RealmManager.shared.saveRequest(city: weather.name, result: "\(Int(weather.main.temp)) °C, \(weather.weather[0].main)", date: date)
                        self.presentInfoForecast(weather: weather)
                    case .failure(let error):
                        self.view?.showAlert(message: error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func presentInfoForecast(weather: Weather) {
        router.showCityForecast(weather)
    }
    
    func presentHistoryRequest() {
        router.showHistoryRequest()
    }
}
