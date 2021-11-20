//
//  NetworkService.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import Foundation
import Alamofire
import CoreLocation
//import SwiftyJSON

fileprivate let apiKey = "4e078ef910f289563d60d6754ffd99bd"
fileprivate let serverUrl = "http://api.openweathermap.org/data/2.5/weather"

fileprivate let newsServerUrl = "http://api.mediastack.com/v1/news?access_key=c87cbea29cba198c2582b6543b37ed7b&sources=en&limit=40"

protocol NetworkServiceProtocol: AnyObject {
    func getForecast(city: String, completion: @escaping (Result<Weather, Error>) -> Void)
    func getForecast(coordinate: CLLocationCoordinate2D, completion: @escaping (Result<Weather, Error>) -> Void)
    func getNews(completion: @escaping (Result<[News], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getNews(completion: @escaping (Result<[News], Error>) -> Void) {
        
        AF.request(newsServerUrl).response { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data,
                          data.count != 0 else {
                              throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "no data available"])
                          }
                    if let error = try? JSONDecoder().decode(NewsResponse.Error.self, from: data) {
                        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error.message])
                    } else {
                        let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                        completion(.success(news.data!))
                    }
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    static var shared: NetworkService = {
        let instance = NetworkService()
        return instance
    }()
    
    private init() {}
    
    private func request(parameters: [String: String], completion: @escaping (Result<Weather, Error>) -> Void) {
        var parameters = parameters
        parameters["units"] = "metric"
        parameters["lang"] = "en"
        parameters["appid"] = apiKey
        
        AF.request(serverUrl, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data,
                          data.count != 0 else {
                              throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "no data available"])
                          }
                    if let error = try? JSONDecoder().decode(Weather.Error.self, from: data) {
                        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error.message])
                    } else {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        completion(.success(weather))
                    }
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
    func getForecast(city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let parameters = [
            "q": city,
        ]
        request(parameters: parameters, completion: completion)
    }
    
    func getForecast(coordinate: CLLocationCoordinate2D, completion: @escaping (Result<Weather, Error>) -> Void) {
        let parameters = [
            "lat": String(coordinate.latitude),
            "lon": String(coordinate.longitude),
        ]
        request(parameters: parameters, completion: completion)
    }
}
