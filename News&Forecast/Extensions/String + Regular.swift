//
//  String + Regular.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 17.11.2021.
//

import Foundation

extension String {
    func isValidCity() -> Bool {
        let cityRegEx = "[A-Za-z\\s-]{1,20}"
        let cityPred = NSPredicate(format:"SELF MATCHES %@", cityRegEx)
        return cityPred.evaluate(with: self)
    }
}
