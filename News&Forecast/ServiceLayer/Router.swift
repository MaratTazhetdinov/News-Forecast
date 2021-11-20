//
//  Router.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import UIKit

protocol RouterMain {
    var navigationControllerForecast: UINavigationController? {get set}
    var navigationControllerNews: UINavigationController? {get set}
    var tabBarController: UITabBarController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
    var initialModule: String? {get set}
}

protocol RouterProtocol: RouterMain {
    func showInitialViewController()
    func showSelectCity()
    func showCityForecast(_ weather: Weather)
    func showMapForecast()
    func showHistoryRequest()
    func showSingleNews(_ news: News?)
}

class Router: RouterProtocol {
    var window: UIWindow?
    var navigationControllerForecast: UINavigationController?
    var navigationControllerNews: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var tabBarController: UITabBarController?
    var initialModule: String?
    
    init(window: UIWindow?, assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = UITabBarController()
        self.assemblyBuilder = assemblyBuilder
        self.navigationControllerForecast = UINavigationController()
        self.navigationControllerNews = UINavigationController()
        self.window = window
    }
    
    func showInitialViewController() {
        if let tabBarController = tabBarController,
           let navigationControllerForecast = navigationControllerForecast,
           let navigationControllerNews = navigationControllerNews
        {
            guard let forecastViewController = assemblyBuilder?.createMenuForecastModule(router: self) else {return}
            guard let newsViewController = assemblyBuilder?.createNewsTableModule(router: self) else {return}
            guard let window = self.window else { return }
            forecastViewController.title = ""
            navigationControllerForecast.viewControllers = [forecastViewController]
            navigationControllerForecast.title = "Forecast"
            navigationControllerNews.viewControllers = [newsViewController]
            navigationControllerNews.title = "News"
            tabBarController.viewControllers = [navigationControllerForecast, navigationControllerNews]
            navigationControllerForecast.tabBarItem.image = UIImage(named: "forecastIcon")
            navigationControllerNews.tabBarItem.image = UIImage(named: "newsIcon")
            
            if #available(iOS 15.0, *){
                let appearance = UITabBarAppearance()
                appearance.configureWithDefaultBackground()
                appearance.backgroundColor = UIColor.black
                
                appearance.compactInlineLayoutAppearance.normal.iconColor = .lightText
                appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.lightText]
                
                appearance.inlineLayoutAppearance.normal.iconColor = .lightText
                appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.lightText]
                
                appearance.stackedLayoutAppearance.normal.iconColor = .lightText
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.lightText]
                
                self.tabBarController?.tabBar.standardAppearance = appearance
                self.tabBarController?.tabBar.scrollEdgeAppearance = self.tabBarController?.tabBar.standardAppearance
                self.tabBarController?.tabBar.tintColor = .white
            }else{
                self.tabBarController?.tabBar.barTintColor = .black
                self.tabBarController?.tabBar.unselectedItemTintColor = .lightText
                self.tabBarController?.tabBar.tintColor = .white
            }
            
            window.rootViewController = tabBarController
            
            if let initialModule = initialModule,
                initialModule == "MapForecastModule" {
                self.showMapForecast()
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func showSelectCity() {
        if let navigationController = navigationControllerForecast {
            guard let cityForecastController = assemblyBuilder?.createCityForecastModule(router: self) else {return}
            navigationController.pushViewController(cityForecastController, animated: true)
        }
    }
    
    func showCityForecast(_ weather: Weather) {
        if let navigationController = navigationControllerForecast {
            guard let infoForecastController = assemblyBuilder?.createInfoForecastModule(weather: weather, router: self) else {return}
            navigationController.pushViewController(infoForecastController, animated: true)
            
        }
    }
    
    func showMapForecast() {
        if let navigationController = navigationControllerForecast {
            guard let mapForecastController = assemblyBuilder?.createMapForecastModule(router: self) else {return}
            navigationController.pushViewController(mapForecastController, animated: true)
        }
    }
    
    func showHistoryRequest() {
        if let navigationController = navigationControllerForecast {
            guard let historyRequestController = assemblyBuilder?.createHistoryRequestModule(router: self) else {return}
            navigationController.pushViewController(historyRequestController, animated: true)
        }
    }
    
    func showSingleNews(_ news: News?) {
        if let navigationController = navigationControllerNews {
            guard let singleNewsController = assemblyBuilder?.createSingleNewsModule(news: news, router: self) else {return}
            navigationController.pushViewController(singleNewsController, animated: true)
        }
    }
    
}
