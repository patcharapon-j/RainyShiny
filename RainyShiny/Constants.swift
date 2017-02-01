//
//  Constants.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/29/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import Foundation

let apiKey = "1fc33246c9dae6928b36487d08590c96"
let api_base = "&appid="
let base_URL = "http://api.openweathermap.org/data/2.5/weather?"
let base_lat = "lat="
let base_long = "&lon="


typealias DownloadComplete = () -> ()

func buildWeatherURL(lat:Double, lon:Double) -> String {
    
    return "\(base_URL)\(base_lat)\(lat)\(base_long)\(lon)\(api_base)\(apiKey)"
    
}

func buildForecastURL(lat:Double, lon:Double, num:Int) -> String {
    
    return "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(lat)&lon=\(lon)&cnt=\(num)&mode=json&appid=\(apiKey)"
}

