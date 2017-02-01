//
//  MainVC.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/29/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var allForecast: [Forecase]!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
        
        allForecast = [Forecase]()
    
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{

            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetail {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }

            
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        
        Alamofire.request(URL(string: buildForecastURL(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude, num: 10))!).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                self.allForecast = [Forecase]()
                
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                    
                    for obj in list{
                        let newForecast = Forecase(list: obj)
                        self.allForecast.append(newForecast)
                    }
                }
            }
            self.tableView.reloadData()
            completed()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell{
            
            let forecast = allForecast[indexPath.row]
            cell.configCell(forecast: forecast)
            
            return cell
        }
        else{
            return ForecastCell()
        }
    }
    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(String(format: "%.1f", currentWeather.currentTemp))°"
        weatherLabel.text = currentWeather.weatherType
        cityLable.text = currentWeather.cityName
        imageMain.image = UIImage(named: weatherLabel.text!)
    }
    
    
}

