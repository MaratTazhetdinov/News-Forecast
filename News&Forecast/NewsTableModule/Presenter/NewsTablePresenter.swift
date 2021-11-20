//
//  NewsTablePresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 14.11.2021.
//

import Foundation

protocol NewsTableViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    
}

protocol NewsTablePresenterProtocol: AnyObject {
    init(view:NewsTableViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getNews()
    var news: [News]? {get set}
    func tapOnTheNews(news: News?)
}

class NewsTablePresenter : NewsTablePresenterProtocol {

    weak var view: NewsTableViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var news: [News]?
    
    required init(view:NewsTableViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.getNews()
    }
    
    func getNews() {
        
        networkService.getNews(completion: { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.news = news
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    func tapOnTheNews(news: News?) {
        router?.showSingleNews(news)
    }
    
}
