//
//  MapForecastPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import Foundation
import CoreLocation
import RxSwift

protocol MapForecastViewProtocol: AlertedViewProtocol {
    func setWeatherData(_ data: String, coordinate: CLLocationCoordinate2D)
//    func setMapLocation(coordinate: CLLocationCoordinate2D)
}

protocol MapForecastPresenterProtocol: AnyObject {
    func setCoordinate(_ coordinate: CLLocationCoordinate2D)
    func updateData()
}

class MapForecastPresenter: MapForecastPresenterProtocol {
    
    let subject = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D())
    let disposeBag = DisposeBag()
    
    weak var view: MapForecastViewProtocol?
    var service: NetworkServiceProtocol?
    var router: RouterProtocol
    
    init(view: MapForecastViewProtocol, service: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.service = service
    }
    
    func setCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        guard view != nil else {return}
        
        self.subject.onNext(coordinate)
        
        self.service?.getForecast(coordinate: coordinate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    var city: String
                    city = weather.name.isEmpty ? "Somewhere" : weather.name
                    let data = "\(city):\n\(Int(weather.main.temp)) °C, \(weather.weather[0].main)"
                    print(data)
                    self.view?.setWeatherData(data, coordinate: coordinate)
                case .failure(let error):
                    self.view?.showAlert(message: error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateData() {
        subject
            .debounce(DispatchTimeInterval.seconds(10), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                self.setCoordinate(value)
            })
            .disposed(by: disposeBag)
    }
    
}


