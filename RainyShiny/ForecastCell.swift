//
//  CellViewTableViewCell.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/31/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLable: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    func configCell(forecast: Forecase){
        lowLabel.text = forecast.lowTemp
        highLable.text = forecast.highTemp
        dayLabel.text = forecast.date
        weatherLabel.text = forecast.weather
        weatherIcon.image = UIImage(named: "\(forecast.weather) Mini")
    }

}
