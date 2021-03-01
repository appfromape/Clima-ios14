//
//  ViewController.swift
//  Clima-ios14
//
//  Created by 程式猿 on 2021/2/26.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    @IBOutlet weak var searchTextFiled: UITextField!
    
    var weatherManerger = WeatherManerger()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManerger.delegate = self
        searchTextFiled.delegate = self
        
    }
    
    @IBAction func getLoction(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextFiled.endEditing(true)
        print(searchTextFiled.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiled.endEditing(true)
        print(searchTextFiled.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextFiled.text != "" {
            return true
        } else {
            searchTextFiled.placeholder = "打些什麼吧"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextFiled.text {
            weatherManerger.fetchWeather(cityName: city)
        }
        searchTextFiled.text = ""
    }
    
}

//MARK: - WeatherManagetDelegate

extension ViewController: WeatherManergerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManerger, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLable.text = weather.tempDicimal
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLable.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            weatherManerger.fetchWeather(lat: lat, lon: lon)
            print("lon: \(lon)  lat: \(lat)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
