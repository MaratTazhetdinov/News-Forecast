//
//  RCManager.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 14.11.2021.
//

import Foundation
import FirebaseRemoteConfig
import SwiftUI

enum RCValues : String {
    case appleMap
}

class RCManager {
    
    static let shared = RCManager()
    
    var defaultValues: [String:Any?] = [
        RCValues.appleMap.rawValue : false
    ]
    
    var remoteConfigConnected: (() -> ())?
    var isActivated: Bool = false
    
    init() {
        RemoteConfig.remoteConfig().setDefaults(defaultValues as? [String:NSObject])
    }
    
    func connected() {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0.0, completionHandler: { status, error in
            guard status == .success else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            RemoteConfig.remoteConfig().activate(completion: { result, error in
                self.isActivated = result
                
                if !result {
                    print(error?.localizedDescription ?? "")
                }
                
                self.remoteConfigConnected?()
            })
        })
    }
    
    func getBoolValues(from key: RCValues) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
}
