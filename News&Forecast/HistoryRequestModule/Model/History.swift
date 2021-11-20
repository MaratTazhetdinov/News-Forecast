//
//  History.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 08.11.2021.
//

import Foundation
import RealmSwift

class History: Object {
    @Persisted var city: String = ""
    @Persisted var result: String = ""
    @Persisted var date: String = ""
    
    convenience init (city: String, result: String, date: String) {
        self.init()
        self.city = city
        self.result = result
        self.date = date
    }
}
