//
//  NetworkManager.swift
//  SimpleWeatherApp
//
//  Created by Jang Seok jin on 2021/08/09.
//

import UIKit
import Alamofire

typealias weatherFetchResult = Result<WeatherResponse, Error>

class NetworkManager {
    
    static let shared = NetworkManager()
    private let token = "9cdba00e89a05cd4e7c47c93f27d3fc5"
    private init() {}
    
    func getDustData(cityName: String, completion: @escaping (weatherFetchResult?)->()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(token)") else { return }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default).responseData { response in
                    print("Response: \(response)")
                    switch response.result {
                    case .success(let data):
                        if let responseData = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                            completion(.success(responseData))
                        } else {
                            print("Decoded Error")
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
            }
        }
    }
}
