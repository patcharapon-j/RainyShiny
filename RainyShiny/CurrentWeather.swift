//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/29/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var cityName:String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date:String {
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp:Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetail (completed: @escaping DownloadComplete) {
        //Alamo file download
        let currentWeatherURL = URL(string: buildWeatherURL(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude))
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            let result = response.result
        
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>]
                {
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any>
                {
                    if let temp = main["temp"] as? Double{
                        self._currentTemp = temp - 273
                    }
                }
                
            }
            
            completed()
        }
        
    }

}
