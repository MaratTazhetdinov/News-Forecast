//
//  SingleNewsPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 17.11.2021.
//

import Foundation

protocol SingleNewsViewProtocol: AnyObject {
    func setNews(news: News?)
}

protocol SingleNewsPresenterProtocol: AnyObject {
    init(view: SingleNewsViewProtocol, router: RouterProtocol, news: News?)
    func setNews()
}

class SingleNewsPresenter: SingleNewsPresenterProtocol {

    weak var view: SingleNewsViewProtocol?
    var router: RouterProtocol?
    var news: News?
    
    required init(view: SingleNewsViewProtocol, router: RouterProtocol, news: News?) {
        self.view = view
        self.router = router
        self.news = news
    }
    
    func setNews() {
        self.view?.setNews(news: news)
    }
    
}
