//
//  HistoryRequestPresenter.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 08.11.2021.
//

import Foundation

protocol HistoryRequestViewProtocol: AnyObject {
    
}

protocol HistoryRequestPresenterProtocol: AnyObject {
    
}

class HistoryRequestPresenter: HistoryRequestPresenterProtocol {
    
    weak var view: HistoryRequestViewProtocol?
    var router: RouterProtocol
    
    init(view: HistoryRequestViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
    
}
