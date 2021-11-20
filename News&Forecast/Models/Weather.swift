//
//  Weather.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 06.11.2021.
//

import Foundation

struct Weather: Codable {
    
    struct Error: Codable {
        let cod: String
        let message: String
    }
    struct Wind: Codable {
        let speed: Double
    }
    struct Weather: Codable {
        let main: String
        let description: String
    }
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        let pressure: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
            case pressure
        }
    }
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}
