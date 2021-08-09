//
//  TempCalculate.swift
//  SimpleWeatherApp
//
//  Created by Jang Seok jin on 2021/08/09.
//

import Foundation

func temperatureInFahrenheit(temperature: Double) -> Double {
    let celsiusTemperature = temperature - 273.15
    return celsiusTemperature
}
