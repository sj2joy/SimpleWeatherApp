//
//  File.swift
//  SimpleWeatherApp
//
//  Created by Jang Seok jin on 2021/08/09.
//

import UIKit

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let main: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
    let humidity: Int
}
