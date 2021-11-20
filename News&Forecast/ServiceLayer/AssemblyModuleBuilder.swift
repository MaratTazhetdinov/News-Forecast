//
//  AssemblyModuleBuilder.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMenuForecastModule(router: RouterProtocol) -> UIViewController
    func createCityForecastModule(router: RouterProtocol) -> UIViewController
    func createInfoForecastModule(weather: Weather?, router: RouterProtocol) -> UIViewController
    func createMapForecastModule(router: RouterProtocol) -> UIViewController
    func createHistoryRequestModule(router: RouterProtocol) -> UIViewController
    func createNewsTableModule(router: RouterProtocol) -> UIViewController
    func createLoadingScreenModule(router: RouterProtocol) -> UIViewController
    func createSingleNewsModule(news: News?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {

    func createMenuForecastModule(router: RouterProtocol) -> UIViewController {
        let view = MenuForecastView()
        let presenter = MenuForecastPresenter(view: view, router: router)
        view.presenter = presenter
        view.title = "Forecast"
        return view
    }
    
    func createCityForecastModule(router: RouterProtocol) -> UIViewController {
        let view = CityForecastView()
        let service = NetworkService.shared
        let presenter = CityForecastPresenter(view: view, service: service, router: router)
        view.presenter = presenter
        return view
    }
    
    func createInfoForecastModule(weather: Weather?, router: RouterProtocol) -> UIViewController {
        let view = InfoForecastView()
        let presenter = InfoForecastPresenter(view: view, weather: weather, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMapForecastModule(router: RouterProtocol) -> UIViewController {
        let view = MapForecastView()
        let service = NetworkService.shared
        let presenter = MapForecastPresenter(view: view, service: service, router: router)
        view.presenter = presenter
        return view
    }
    
    func createHistoryRequestModule(router: RouterProtocol) -> UIViewController {
        let view = HistoryRequestView()
        let presenter = HistoryRequestPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createNewsTableModule(router: RouterProtocol) -> UIViewController {
        let view = NewsTableView()
        let service = NetworkService.shared
        let presenter = NewsTablePresenter(view: view, networkService: service , router: router)
        view.presenter = presenter
        return view
    }
    
    func createSingleNewsModule(news: News?, router: RouterProtocol) -> UIViewController {
        let view = SingleNewsView()
        let presenter = SingleNewsPresenter(view: view, router: router, news: news)
        view.presenter = presenter
        return view
    }
    
    func createLoadingScreenModule(router: RouterProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "LoadingScreenViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoadingScreenViewController") as! LoadingScreenViewController
        vc.router = router
        return vc
    }

}
