//
//  RealmManager.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 08.11.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let localRealm = try! Realm()
    
    func saveRequest(city: String, result: String, date: String) {
        let request = History(city: city, result: result, date: date)
        
        do {
            try localRealm.write {
                localRealm.add(request)
                print("Request saved")
            }
        } catch(let e) {
            print(e)
        }
    }
    
    func getAllRequests() -> Results<History> {
        let requests = localRealm.objects(History.self)
        return requests
    }
}
