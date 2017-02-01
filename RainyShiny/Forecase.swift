//
//  Forecase.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/31/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import UIKit
import Alamofire

class Forecase {
    
    var _date: String!
    var _weather: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weather: String {
        if _weather == nil{
            _weather = ""
        }
        return _weather
    }
    
    var highTemp: String {
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(list: Dictionary<String, Any>) {
        
        if let temp = list["temp"] as? Dictionary<String, Any> {
            _highTemp = String(format: "%.1f", (temp["max"] as? Double)! - 273) + "°"
            _lowTemp = String(format: "%.1f", (temp["min"] as? Double)! - 273) + "°"        }
        
        if let weather = list["weather"] as? [Dictionary <String, Any>] {
            _weather = weather[0]["main"] as? String
        }
        if let dt = list["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
